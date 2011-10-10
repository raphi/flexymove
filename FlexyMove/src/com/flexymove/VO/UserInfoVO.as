package com.flexymove.VO
{
	[Bindable]
	public class UserInfoVO
	{
		public var name : String;
		public var password : String;
		private var _uid:String;
		
		public function UserInfoVO()
		{
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