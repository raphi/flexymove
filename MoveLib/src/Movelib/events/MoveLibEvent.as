package Movelib.events
{
	import flash.events.Event;
	
	public class MoveLibEvent extends Event
	{
		public static var FRAME_ANALYSED:String = "FrameAnalysed";
		
		public function MoveLibEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}