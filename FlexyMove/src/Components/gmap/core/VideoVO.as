package Components.gmap.core
{
	import com.google.maps.LatLng;
	
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	[Bindable]
	[RemoteClass] 
	public class VideoVO implements IUID
	{
		public var author:String;
		public var latlng:LatLng;
		private var _uid:String;
		
		public function VideoVO(author:String, latlng:LatLng)
		{
			this.author = author;
			this.latlng = latlng;
			
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