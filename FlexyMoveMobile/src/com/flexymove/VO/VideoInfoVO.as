package com.flexymove.VO
{
	import com.google.maps.LatLng;
	
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	[Bindable]
	public class VideoInfoVO implements IUID
	{
		public var pseudo:String = "";
		public var channel:String = "";
		public var address:String = "";
		public var date:Date;
		public var idYoutubeVideo:String = "";
		public var description:String = "";
		public var title:String = "";
		public var time:String = ""; // FIXME to delete?
		public var lat:Number = 0;
		public var lng:Number = 0;
		public var playerType : String= "youtube";
		private var _uid:String;
		public var nbViews:int = 0;		
		public function VideoInfoVO(pseudo:String="", lat:Number=0, lng:Number=0)
		{
			this.pseudo = pseudo;
			this.lat = lat;
			this.lng = lng;
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