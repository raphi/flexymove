package Components.gmap.core
{
	import com.google.maps.LatLng;
	
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	public class VideoVO implements IUID
	{
		public var author:String;
		public var lat:Number;
		public var lng:Number;
		private var _uid:String;
		
		public function VideoVO()
		{
			_uid = UIDUtil.createUID();
		}
		
		public function get uid():String
		{
			return _uid;
		}
		
		public function set uid(value:String):void
		{
			_uid = value;
		}
		
	}
}