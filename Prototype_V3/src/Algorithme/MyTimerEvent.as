package Algorithme
{
	import flash.events.Event;

	public class MyTimerEvent extends Event
	{
		static public const END_PROCESSING_FRAME:String = "ENDPROCESSINGFRAME";
		public function MyTimerEvent(e:String)
		{
			super(e);
		}
		
		
	}
}