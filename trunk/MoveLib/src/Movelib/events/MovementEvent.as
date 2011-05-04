package Movelib.events
{
	import flash.events.TransformGestureEvent;
	
	public class MovementEvent extends TransformGestureEvent
	{
		public static var SWIPE_LEFT:String = "SwipeLeft";
		public static var SWIPE_RIGHT:String = "SwipeRight";
		public static var SWIPE_TOP:String = "SwipeTop";
		public static var SWIPE_BOTTOM:String = "SwipeBottom";
		
		public function MovementEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, phase:String=null, localX:Number=0, localY:Number=0, scaleX:Number=1.0, scaleY:Number=1.0, rotation:Number=0, offsetX:Number=0, offsetY:Number=0, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false)
		{
			super(type, bubbles, cancelable, phase, localX, localY, scaleX, scaleY, rotation, offsetX, offsetY, ctrlKey, altKey, shiftKey);
		}
	}
}