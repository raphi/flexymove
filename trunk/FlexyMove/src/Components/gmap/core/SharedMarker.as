package Components.gmap.core
{
	import com.flexymove.GMapUtils;
	import com.flexymove.MarkerManager;
	import com.flexymove.VO.VideoInfoVO;
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	public class SharedMarker extends Marker
	{
		public var videoInfo:VideoInfoVO;
		
		public function SharedMarker(latitudeAndLongitude:LatLng, videoInfoVO:VideoInfoVO = null, markerOptions:MarkerOptions = null)
		{
			if (videoInfoVO)
				this.videoInfo = videoInfoVO;
			else
			{
				this.videoInfo = new VideoInfoVO("currentUser", latitudeAndLongitude.lat(), latitudeAndLongitude.lng());
				this.videoInfo.channel = "Green Paris";
				this.videoInfo.pseudo = "Metalikange";
				// load the adress here
				//this.videoInfo.address = gmapUtils.getAddressFromLatLng(latitudeAndLongitude);
			}
				
			super(latitudeAndLongitude, markerOptions);
		}
	}
}