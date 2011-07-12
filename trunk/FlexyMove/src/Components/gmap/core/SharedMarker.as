package Components.gmap.core
{
	import com.flexymove.Utils.GMapUtils;
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
				//this.videoInfo.address = GMapUtils.getAddressFromLatLng(latitudeAndLongitude);
			}
				
			super(latitudeAndLongitude, markerOptions);
		}
	}
}