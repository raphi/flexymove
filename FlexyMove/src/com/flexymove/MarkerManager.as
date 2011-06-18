package com.flexymove
{
	import Components.gmap.core.MarkerManager;
	import Components.gmap.core.SharedMarker;
	
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.ConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	import com.flexymove.VO.VideoInfoVO;
	import com.google.maps.LatLng;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	import com.google.maps.services.Placemark;
	
	import flash.events.EventDispatcher;
	
	public class MarkerManager extends EventDispatcher
	{
		private var gmarkerManager:Components.gmap.core.MarkerManager;
		private var _sharedVideoList:CollectionNode;
		
		public function MarkerManager(map:IMap, connectSession:ConnectSession)
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
		
		/**
		 * Add a marker on the map and synchronize it with the server
		 */
		public function addMarker(marker:SharedMarker):void
		{
			_sharedVideoList.publishItem(new MessageItem("videoList", marker.videoInfo, marker.videoInfo.uid));
		}
		
		// Re-dispatch the event (to be listan by view here)
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
				var marker:SharedMarker = new SharedMarker(new LatLng(videoVO.lat, videoVO.lng), videoVO);
				
				marker.addEventListener(MapMouseEvent.CLICK, onMarkerClick);
				gmarkerManager.addMarker(marker, 0, 10);
			}
		}
	}
}