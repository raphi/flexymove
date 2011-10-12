package com.flexymove.Utils
{
	import flash.events.Event;

	public class GMapUtilsEvent extends Event
	{
		public static const GET_ADDRESS:String = "getAddress";
		
		public var address:String;
		
		public function GMapUtilsEvent(type:String, address:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.address = address;
			super(type, bubbles, cancelable);
		}
	}
}