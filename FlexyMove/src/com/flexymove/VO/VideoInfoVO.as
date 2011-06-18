package com.flexymove.VO
{
	import com.google.maps.LatLng;
	
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	public class VideoInfoVO implements IUID
	{
		public var pseudo:String = "";
		public var channel:String = "";
		public var address:String = "";
		public var lat:Number = 0;
		public var lng:Number = 0;
		private var _uid:String;
		
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