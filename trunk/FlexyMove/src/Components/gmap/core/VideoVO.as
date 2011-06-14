package Components.gmap.core
{
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	public class VideoVO implements IUID
	{
		public var author:String;
		public var lat:Number;
		public var long:Number;
		private var _uid:String;
		
		public function VideoVO(author:String, lat:Number, long:Number)
		{
			this.author = author;
			this.lat = lat;
			this.long = long;
			
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