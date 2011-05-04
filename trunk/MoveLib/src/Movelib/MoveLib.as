package Movelib
{
	import Movelib.Pointsdetection.PointsDetection;
	import Movelib.colorsDetection.ColorsDetection;
	import Movelib.events.MoveLibEvent;
	import Movelib.imageAcquisition.ImageAcquisition;
	import Movelib.preProcessing.PreProcessing;
	import Movelib.recognition.Recognition;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;

	public class MoveLib
	{
		private static var _ImgAcq:ImageAcquisition;
		private static var _PreProc:PreProcessing
		private static var _ColDetect:ColorsDetection;
		private static var _PointsDetect:PointsDetection;
		
		/*public just for debug*/
		public static var _Reco:Recognition;
		private static var _registeredObjects:Array = new Array();
		private static var _timer:Timer
		private static var frameAnalysedEvent:MoveLibEvent;
		
		public function MoveLib()
		{
		}
		
		/** initialisation of the MoveLib */
		public static function start(frequency:Number=1000/25) : void
		{
			_ImgAcq = new ImageAcquisition();
			_PreProc = new PreProcessing();
			_ColDetect = new ColorsDetection();
			_PointsDetect = new PointsDetection();
			_Reco = new Recognition();
			frameAnalysedEvent = new MoveLibEvent(MoveLibEvent.FRAME_ANALYSED);
			
			//init the timer and start it
			_timer = new Timer(frequency, 0);
			_timer.addEventListener("timer", frame);
			_timer.start();
		}

		/** Register objects to accept move events */
		public static function registerObject(...UIobject) : void
		{
			for each (var object:Object in UIobject)
			{
				if (object is UIComponent)
					_registeredObjects.push(object);
			}

		}
		
		public static function dispatchEventToMovelibObjects(e:Event) : void
		{
			for each (var obj:UIComponent in _registeredObjects)
				obj.dispatchEvent(e);
		}
		
		/** The function called by the timer */
		public static function frame(s:String) : void
		{
			//Begin frame
			//Capture the picture
			var img:BitmapData = _ImgAcq.capturePicture();
			//Apply the pre-traitement
			PreProc.apply(img);
			//Detect colors
			ColDetect.detect(img);
			//get the detected colors to the PointsDetect object
			PointsDetect.colors = ColDetect.colors;
			//Transform the detected colors to points
			PointsDetect.detect(img);
			if (PointsDetect.askForRecalibration)
			{
				ColDetect.reset();
				PointsDetect.askForRecalibration = false;
				return;
			}
			//Give the detected points to the Recognition object
			Reco.addAll(PointsDetect.points);
			Reco.recognize(img);
			
			//end frame
		}
		
		public static function get PointsDetect():PointsDetection
		{
			return _PointsDetect;
		}
		
		public static function get ColDetect():ColorsDetection
		{
			return _ColDetect;
		}
		
		public static function get PreProc():PreProcessing
		{
			return _PreProc;
		}
		
		public static function get ImgAcq():ImageAcquisition
		{
			return _ImgAcq;
		}
		
		public static function get Reco():Recognition
		{
			return _Reco;
		}
	}
}