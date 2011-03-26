package Movelib
{
	import Movelib.Pointsdetection.PointsDetection;
	import Movelib.colorsDetection.ColorsDetection;
	import Movelib.imageAcquisition.ImageAcquisition;
	import Movelib.preProcessing.PreProcessing;
	import Movelib.recognition.Recognition;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;

	public class MoveLib
	{
		private static var _ImgAcq:ImageAcquisition;
		private static var _PreProc:PreProcessing
		private static var _ColDetect:ColorsDetection;
		private static var _PointsDetect:PointsDetection;
		private static var _Reco:Recognition;
		private static var _timer:Timer
		private static var _obj:UIComponent;
		
		public function MoveLib()
		{
		}
		public static function getString() : String
		{
			return "You've succeeded to accessed to the library";
		}
		/** initialisation of the MoveLib */
		public static function start() : void
		{
			_ImgAcq = new ImageAcquisition();
			_PreProc = new PreProcessing();
			_ColDetect = new ColorsDetection();
			_PointsDetect = new PointsDetection();
			_Reco = new Recognition();
			//init the timer and start it
			_timer = new Timer(1000/30, 0);
			_timer.addEventListener("timer", frame);
			_timer.start();
		}

		/** records an object to accept move events */
		public static function registerObject(o:UIComponent) : void
		{
			_obj = o;
		}
		
		/** The function called by the timer */
		public static function frame(s:String) : void
		{
			//begin frame
			//Capture the picture
			var img:BitmapData = _ImgAcq.capturePicture();
			//Apply the pre-traitement
			PreProc.apply(img);
			//Detect colors
			ColDetect.detect(img);
			//Transform the detected colors to points
			//PointsDetect.detect(img);
			//Give the deteced points to the Recognition object
			//Reco.addAll(PointsDetect.points);
			//Reco.recognize();
			var e:MouseEvent = new MouseEvent("click");
			_obj.dispatchEvent(e);
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