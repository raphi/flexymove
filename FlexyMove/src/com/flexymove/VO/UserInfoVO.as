package com.flexymove.VO
{
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	[Bindable]
	public class UserInfoVO implements IUID
	{
		public var name : String;
		public var password : String;
		private var _uid:String;
		
		public function UserInfoVO()
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