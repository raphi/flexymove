package com.flexymove.Managers
{
	import Components.gmap.core.MarkerManager;
	import Components.gmap.core.SharedMarker;
	
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.ConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	import com.flexymove.Utils.Utils;
	import com.flexymove.VO.VideoInfoVO;
	import com.google.maps.LatLng;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
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
		private static var instance:MarkerManager;
		
		public static function getInstance():MarkerManager
		{
			if( instance == null ) instance = new MarkerManager();
			return instance;
		}
		
		public function MarkerManager()
		{
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
			for (var i : int = 0; i < videoInfosList.length;i++)
			{
				var videoVO : VideoInfoVO = VideoInfoVO(videoInfosList.getItemAt(i));
				
				if(videoVO.playerType == "picture" && Utils.urlIsPicture(videoVO.idYoutubeVideo))
					pictureList.addItem(videoInfosList.getItemIndex(i));
				
			}
			return pictureList;
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
				// FIXME : add this functionnality
				/*var markerOption:MarkerOptions = new MarkerOptions({draggable: true})
				var marker:SharedMarker = new SharedMarker(new LatLng(videoVO.lat, videoVO.lng), videoVO, markerOption);
				
				marker.addEventListener(MapMouseEvent.CLICK, onMarkerClick);
				gmarkerManager.addMarker(marker, 0, 15);*/
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
			
			marker.addEventListener(MapMouseEvent.CLICK, onMarkerClick);
			//SET visibilité view
			gmarkerManager.addMarker(marker, 0, 15);
		}
		
		public function displayVideoAndOrPicture(picture : Boolean , video : Boolean): void
		{
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
		
		public function uptdateMapWithSearchResult(searchCriterias : ArrayCollection, fieldToSearch :String):void
		{
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
					
					if (fieldToSearch == "title" && videoVO.title.indexOf(searchCriterias.getItemAt(j) as String,0) != -1)
					{
						createMarker(videoVO);
						videoDisplayInfosList.addItem(videoVO);
						break;
					}
					if (fieldToSearch == "pseudo" && videoVO.pseudo.indexOf(searchCriterias.getItemAt(j) as String,0) != - 1)
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
					if (fieldToSearch == "channel" && videoVO.channel.indexOf(searchCriterias.getItemAt(j) as String,0) != -1)
					{
						createMarker(videoVO);
						videoDisplayInfosList.addItem(videoVO);
						break;
					}
				}
			}
			
		}
		
	}
}