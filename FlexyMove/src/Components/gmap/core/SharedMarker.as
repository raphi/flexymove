package Components.gmap.core
{
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.events.SharedObjectEvent;
	import com.adobe.rtc.sharedModel.SharedCollection;
	import com.adobe.rtc.sharedModel.SharedObject;
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import mx.core.IUID;
	import mx.events.CollectionEvent;
	
	public class SharedMarker extends Marker
	{
		public function SharedMarker(latitudeAndLongitude:LatLng, markerOptions:MarkerOptions=null)
		{
			super(latitudeAndLongitude, markerOptions);
			initializeSharedObject();
		}
		
		private var _sharedVideo:SharedCollection;
		
		private function initializeSharedObject():void
		{
			_sharedVideo = new SharedCollection();
			_sharedVideo.nodeName = "videoList";
			_sharedVideo.sharedID = "videoShared";
			_sharedVideo.idField = "uid";

			_sharedVideo.subscribe();
			_sharedVideo.addEventListener(CollectionNodeEvent.SYNCHRONIZATION_CHANGE, onSharedObjSync);
			_sharedVideo.addEventListener(SharedObjectEvent.PROPERTY_REMOVE,onSharedObjChange);
			_sharedVideo.addEventListener(SharedObjectEvent.PROPERTY_ADD,onSharedObjChange);
			_sharedVideo.addEventListener(SharedObjectEvent.PROPERTY_REMOVE, onSharedObjChange);
		}
		
		private function onSharedObjSync(p_evt:CollectionNodeEvent):void
		{
			if (_sharedVideo.isSynchronized) 
			{
				var video:VideoVO = new VideoVO("raphi", 4945, 48445);
				
				_sharedVideo.addItem(IUID(video));
			}
		}
		
		private function onSharedObjChange(p_evt:SharedObjectEvent):void
		{
			if (_sharedVideo.isSynchronized) 
			{
				var key:String = p_evt.propertyName;
				// Example of SharedObject.getProperty
				// Check if the SharedObject is empty
			}
		}
	}
}