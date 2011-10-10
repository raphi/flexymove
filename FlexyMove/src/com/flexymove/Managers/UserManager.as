package com.flexymove.Managers
{
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.ConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	import com.flexymove.VO.UserInfoVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayList;
	
	/**
	 * Singleton class.
	 */ 
	[Bindable]
	public class UserManager extends EventDispatcher
	{
		public var currentUserInfo : UserInfoVO = new UserInfoVO();
		private var _userList : CollectionNode;
		public var userList : ArrayList = new ArrayList();
		
		private static var instance:UserManager;
		
		public static function getInstance():UserManager
		{
			if( instance == null ) instance = new UserManager();
			return instance;
		}
		
		public function UserManager()
		{
		}
		
		public function initializeUserList(connectSession:ConnectSession):void
		{
			_userList = new CollectionNode();
			_userList.connectSession = connectSession;
			_userList.sharedID = "users";
			
			_userList.addEventListener(CollectionNodeEvent.ITEM_RECEIVE, onCollectionChange);
			
			_userList.subscribe();
			
			// This will serialize the objects and then we can cast then when we receive then from the server
			MessageItem.registerBodyClass(UserInfoVO);
		}
		
		public function createNewUser(user : UserInfoVO):void
		{
			_userList.publishItem(new MessageItem("userList", user, user.uid));
		}
		
		public function userIsValid(user : UserInfoVO):Boolean
		{
			for (var i : int = 0; i < userList.length; i++)
			{
				if (user.name == userList.getItemAt(i).name && user.password == userList.getItemAt(i).password)
					return true;
			}
			return false;
		}
		
		private function onCollectionChange(e:CollectionNodeEvent):void
		{
			var userInfo:UserInfoVO = e.item.body as UserInfoVO;
			
			if (userInfo)
			{
				userList.addItem(userInfo);
			}
			
			dispatchEvent( new Event( 'getLoginsSuccessful' ));
		}
	}
	
}