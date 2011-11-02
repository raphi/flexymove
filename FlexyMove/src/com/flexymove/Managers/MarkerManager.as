package com.flexymove.Managers
{
	import Components.gmap.core.MarkerManager;
	import Components.gmap.core.SharedMarker;
	
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.ConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	import com.flexymove.Utils.GMapUtils;
	import com.flexymove.Utils.Utils;
	import com.flexymove.VO.VideoInfoVO;
	import com.google.maps.LatLng;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	
	/**
	 * Singleton class.
	 * Handles marker on the google map.
	 */ 
	public class MarkerManager extends EventDispatcher
	{
		private var gmarkerManager:Components.gmap.core.MarkerManager;
		private var _sharedVideoList:CollectionNode;

		private var videoInfosList:ArrayList = new ArrayList();
		private var videoDisplayInfosList:ArrayList = new ArrayList();
		private var _markers:ArrayCollection = new ArrayCollection();
		private var _lastZoom:int = 1;
		[Bindable]
		public var searchList:ArrayCollection = new ArrayCollection;
		
		private static var instance:MarkerManager;
		
		public static function getInstance():MarkerManager
		{
			if( instance == null ) instance = new MarkerManager();
			return instance;
		}
		
		public function MarkerManager()
		{
			// FIXME dirty
			searchList.addItem(new ArrayCollection);
			searchList.addItem(new ArrayCollection);
			searchList.addItem(new ArrayCollection);
			searchList.addItem(new ArrayCollection);
		}
		
		/**
		 * Init the marker manager with the gmap and livecycle connection
		 */
		public function init(map:IMap, connectSession:ConnectSession):void
		{
			gmarkerManager = new Components.gmap.core.MarkerManager(map);
			initializeSharedList(connectSession);
		}
		
		/**
		 * Set variable to bind the correct database in LCCS
		 */
		private function initializeSharedList(connectSession:ConnectSession):void
		{
			_sharedVideoList = new CollectionNode();
			_sharedVideoList.connectSession = connectSession;
			_sharedVideoList.sharedID = "videoShared";
			
			_sharedVideoList.addEventListener(CollectionNodeEvent.ITEM_RECEIVE, onCollectionChange);
			
			_sharedVideoList.subscribe();
			
			// This will serialize the objects and then we can cast then when we receive then from the server
			MessageItem.registerBodyClass(VideoInfoVO);
		}
		
		public function getVideoList():ArrayList
		{
			return videoInfosList;
		}
		
		public function getVideoDisplayInfosList():ArrayList
		{
			return videoDisplayInfosList;
		}
		
		public function getAllPictures():ArrayList
		{
			var pictureList :ArrayList = new ArrayList();
			for (var i : int = 0; i < videoInfosList.length; i++)
			{
				var videoVO : VideoInfoVO = VideoInfoVO(videoInfosList.getItemAt(i));
				
				if(videoVO.playerType == "picture" && Utils.urlIsPicture(videoVO.idYoutubeVideo))
					pictureList.addItem(videoInfosList.getItemIndex(i));
				
			}
			return pictureList;
		}
		
		public function getVideosFromChannel(channelName:String):ArrayList
		{
			var itemList: ArrayList = new ArrayList();
			
			for (var i : int = 0; i < videoInfosList.length; i++)
			{
				var videoVO : VideoInfoVO = VideoInfoVO(videoInfosList.getItemAt(i));
				
				if ((videoVO.playerType == "youtube" || videoVO.playerType == "dailymotion")
					&& videoVO.channel == channelName)
					itemList.addItem(videoVO);
			}
			
			return itemList;
		}
		
		/**
		 * Add a marker on the map and synchronize it with the server
		 */
		public function addMarker(marker:SharedMarker):void
		{
			_sharedVideoList.publishItem(new MessageItem("videoList", marker.videoInfo, marker.videoInfo.uid));
		}
		
		// Re-dispatch the event (to be listen by view here)
		private function onMarkerClick(e:MapMouseEvent):void
		{
			var evt:MapMouseEvent = new MapMouseEvent(MapMouseEvent.CLICK, e.target, e.latLng);
			
			dispatchEvent(evt);
		}
		
		private function onCollectionChange(e:CollectionNodeEvent):void
		{
			var videoVO:VideoInfoVO = e.item.body as VideoInfoVO;
			
			if (videoVO)
			{
				videoInfosList.addItem(videoVO);
				videoDisplayInfosList.addItem(videoVO);
				createMarker(videoVO);
				addInformationInSearchList(videoVO);
			}
		}
		
		private function createMarker(videoVO:VideoInfoVO):void
		{
			var markerOption:MarkerOptions = new MarkerOptions({
				strokeStyle: new StrokeStyle({color: 0x987654}),
				fillStyle: new FillStyle({color: 0x223344, alpha: 0.8}),
				radius: 12,
				hasShadow: true,
				draggable: true
			});
			
			if (videoVO.playerType == "picture")
				markerOption = new MarkerOptions({
					strokeStyle: new StrokeStyle({color: 0x987654}),
					fillStyle: new FillStyle({color: 0xEDE382, alpha: 0.8}),
					radius: 12,
					hasShadow: true,
					draggable: true
				});
			
			//markerOption.strokeStyle = style; 
			var marker:SharedMarker = new SharedMarker(new LatLng(videoVO.lat, videoVO.lng), videoVO, markerOption);
			_markers.addItem(marker);
			
			marker.addEventListener(MapMouseEvent.CLICK, onMarkerClick);
			marker.addEventListener(MapMouseEvent.DRAG_END, onMarkerMoved);
			
			// SET visibilité view
			// FIXME handle level zoom
			gmarkerManager.addMarker(marker, 0, 15);
		}
		
		// This send to the server the same marker with refresh lat lng.
		private function onMarkerMoved(event : MapMouseEvent):void
		{
			var marker : SharedMarker = event.target as SharedMarker;
			
			marker.videoInfo.lat = event.latLng.lat();
			marker.videoInfo.lng = event.latLng.lng();
			
			// Avoid doublons, the marker will be recreated with onCollectionChange
			gmarkerManager.removeMarker( marker );
			
			_sharedVideoList.publishItem(new MessageItem("videoList", marker.videoInfo, marker.videoInfo.uid), true);
		}
		
		public function updateVideoInfo(videoInfo:VideoInfoVO):void
		{
			_sharedVideoList.publishItem(new MessageItem("videoList", videoInfo, videoInfo.uid), true);
		}
		
		public function displayVideoAndOrPicture(picture : Boolean , video : Boolean): void
		{
			_markers.removeAll();
			gmarkerManager.clearMarkers();
			
			for (var i:int = 0; i<videoDisplayInfosList.length; i++)
			{
				var videoVO : VideoInfoVO = VideoInfoVO(videoDisplayInfosList.getItemAt(i));
				if(picture && videoVO.playerType == "picture" && Utils.urlIsPicture(videoVO.idYoutubeVideo))
				{
					createMarker(videoVO);
				}
				if(video && videoVO.playerType != "picture")
				{
					createMarker(videoVO);
				}
				
			}
		}
		
		private function addInformationInSearchList(videoinfo : VideoInfoVO) : void
		{
			var myPattern:RegExp = /, /g;
			
			var place : String = videoinfo.address.replace(myPattern, ",");
			var addtab : Array = place.split(",");
			
			place = place.split(",")[place.split(",").length - 1];
			var city : String="";
			if (addtab.length >= 2)
				city= addtab[addtab.length - 2];
			if (!searchList.getItemAt(0).contains(videoinfo.title))
				searchList.getItemAt(0).addItem(videoinfo.title);
			
			if (!searchList.getItemAt(3).contains(videoinfo.channel))
				searchList.getItemAt(3).addItem(videoinfo.channel);
			
			if (!searchList.getItemAt(2).contains(place))
			{
				searchList.getItemAt(2).addItem(place);
				//listPlace.addItem(city);
			}
			if (!searchList.getItemAt(1).contains(videoinfo.pseudo))
				searchList.getItemAt(1).addItem(videoinfo.pseudo);
		}
		
		public function uptdateMapWithSearchResult(searchCriterias : ArrayCollection, fieldToSearch :String):void
		{
			_markers.removeAll();
			gmarkerManager.clearMarkers();
			videoDisplayInfosList = new ArrayList();
			for (var i:int = 0; i<videoInfosList.length; i++)
			{
				var videoVO : VideoInfoVO = VideoInfoVO(videoInfosList.getItemAt(i));
				if (searchCriterias.length == 0)
				{
					createMarker(videoVO);
					videoDisplayInfosList.addItem(videoVO);
					continue;
				}
				
				var myPattern:RegExp = /, /g;
				
				var place : String = videoVO.address.replace(myPattern, ",");
				place = place.split(",")[place.split(",").length - 1];
				
				for (var j : int = 0 ; j <searchCriterias.length;j++)
				{
					
					if (fieldToSearch == "title" && videoVO.title.toLowerCase().indexOf(searchCriterias.getItemAt(j).toLowerCase() as String,0) != -1)
					{
						createMarker(videoVO);
						videoDisplayInfosList.addItem(videoVO);
						break;
					}
					if (fieldToSearch == "pseudo" && videoVO.pseudo.toLowerCase().indexOf(searchCriterias.getItemAt(j).toLowerCase() as String,0) != - 1)
					{
						createMarker(videoVO);
						videoDisplayInfosList.addItem(videoVO);
						break;
					}
					if (fieldToSearch == "address" && place == searchCriterias.getItemAt(j))
					{
						createMarker(videoVO);
						videoDisplayInfosList.addItem(videoVO);
						break;
					}
					if (fieldToSearch == "channel" && videoVO.channel.toLowerCase().indexOf(searchCriterias.getItemAt(j).toLowerCase() as String,0) != -1)
					{
						createMarker(videoVO);
						videoDisplayInfosList.addItem(videoVO);
						break;
					}
				}
			}
			Clusterize(_lastZoom);
		}
		
		public function Clusterize(zoom:int):void
		{
			_lastZoom = zoom;
			var clusterer:Clusterer = null;
			clusterer = new Clusterer(_markers.toArray(), zoom);
			var clusters:Array = clusterer.clusters;
			gmarkerManager.clearMarkers();
			for each(var cluster:Array in clusters)
			{
				var marker:SharedMarker = null;
				for each(var m:SharedMarker in cluster)
				{
					if ((marker == null) || (m.videoInfo.nbViews > marker.videoInfo.nbViews))
						marker = m;
				}
				gmarkerManager.addMarker(marker, 0, Infinity);
			}
		}
		
	}
}