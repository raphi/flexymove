package com.flexymove.Managers
{
	import com.flexymove.VO.UserInfo;

	/**
	 * Singleton class.
	 */ 
	[Bindable]
	public class UserManager
	{
		public var userInfo : UserInfo = new UserInfo();
		
		private static var instance:UserManager;
		
		public static function getInstance():UserManager
		{
			if( instance == null ) instance = new UserManager();
			return instance;
		}
		
		public function UserManager()
		{
		}
	}

}