package Components.gmap.core
{
	import com.flexymove.Utils.GMapUtils;
	import com.flexymove.Utils.GMapUtilsEvent;
	import com.flexymove.VO.VideoInfoVO;
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.events.Event;
	
	public class SharedMarker extends Marker
	{
		public var videoInfo:VideoInfoVO;
		private var gmapUtils:GMapUtils = new GMapUtils();
		
		public function SharedMarker(latitudeAndLongitude:LatLng, videoInfoVO:VideoInfoVO = null, markerOptions:MarkerOptions = null)
		{
			if (videoInfoVO)
				this.videoInfo = videoInfoVO;
			else
			{
				this.videoInfo = new VideoInfoVO("currentUser", latitudeAndLongitude.lat(), latitudeAndLongitude.lng());
				this.videoInfo.channel = "Green Paris";
				this.videoInfo.pseudo = "Metalikange";
				
				gmapUtils.addEventListener(GMapUtilsEvent.GET_ADDRESS, onGetAddress);
				gmapUtils.getAddressFromLatLng(latitudeAndLongitude);
			}
			
			super(latitudeAndLongitude, markerOptions);
		}
		
		private function onGetAddress(evt:GMapUtilsEvent):void
		{
			this.videoInfo.address = evt.address;
			dispatchEvent(new Event("SHARED_MARKER_CREATION_COMPLETE"));
		}
	}
}