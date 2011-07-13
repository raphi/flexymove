package com.flexymove.Managers
{
	/**
	 * Handle the current view.
	 */
	[Bindable]
	public class NavigatorManager
	{
		public static const GMAP_VIEW:int = 0;
		public static const CHANNEL_VIEW:int = 1;
		
		private static var instance:NavigatorManager;
		
		public var currentView:int = GMAP_VIEW;
		
		public function NavigatorManager()
		{
		}
		
		public static function getInstance():NavigatorManager
		{
			if( instance == null ) instance = new NavigatorManager();
			return instance;
		}
	}
}