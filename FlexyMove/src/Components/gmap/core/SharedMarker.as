package Components.gmap.core
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.flexymove.VO.VideoVO;
	
	public class SharedMarker extends Marker
	{
		public var video:VideoVO;
		
		public function SharedMarker(latitudeAndLongitude:LatLng, videoVO:VideoVO = null, markerOptions:MarkerOptions = null)
		{
			video = videoVO;
				
			super(latitudeAndLongitude, markerOptions);
		}
	}
}