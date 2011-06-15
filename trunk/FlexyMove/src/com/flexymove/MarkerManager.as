package com.flexymove
{
	import Components.gmap.core.MarkerManager;
	import Components.gmap.core.SharedMarker;
	import Components.gmap.core.VideoVO;
	
	import com.adobe.rtc.sharedModel.SharedCollection;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.overlays.Marker;
	
	import mx.events.CollectionEvent;
	
	public class MarkerManager
	{
		private var gmarkerManager:Components.gmap.core.MarkerManager;
		private var _sharedVideoList:SharedCollection;
		
		public function MarkerManager(map:IMap)
		{
			gmarkerManager = new Components.gmap.core.MarkerManager(map);
			initializeSharedList();
		}
		
		private function initializeSharedList():void
		{
			_sharedVideoList = new SharedCollection();
			_sharedVideoList.nodeName = "videoList";
			_sharedVideoList.sharedID = "videoShared";
			_sharedVideoList.idField = "uid";
			
			_sharedVideoList.subscribe();
			
			_sharedVideoList.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange);
		}
		
		public function addMarker(marker:SharedMarker):void
		{
			_sharedVideoList.addItem(marker.video);
		}
		
		private function onCollectionChange(e:CollectionEvent):void
		{
			// Connection with LiveCycle enable
			if (_sharedVideoList.isSynchronized)
			{
				var videoVO:* = e.items.pop();
				var marker:SharedMarker = new SharedMarker(videoVO.latlng, videoVO);
				
				gmarkerManager.addMarker(marker, 0, 10);
			}
		}
	}
}