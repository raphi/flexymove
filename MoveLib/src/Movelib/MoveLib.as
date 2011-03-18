package Movelib
{
	import Movelib.Pointsdetection.PointsDetection;
	import Movelib.colorsDetection.ColorsDetection;
	import Movelib.imageAcquisition.ImageAcquisition;
	import Movelib.recognition.Recognition;
	import Movelib.preProcessing.PreProcessing;
	
	import flash.display.BitmapData;

	public class MoveLib
	{
		private static var ImgAcq:ImageAcquisition;
		private static var PreProc:PreProcessing
		private static var ColDetect:ColorsDetection;
		private static var PointsDetect:PointsDetection;
		private static var Reco:Recognition;
		
		public function MoveLib()
		{
		}

		/** initialisation of the MoveLib */
		public static function init() : void
		{
			//init the timer and start it
		}

		/** records an object to accept move events */
		public static function registerObject(o:Object) : void
		{
			
		}
		
		/** The function called by the timer */
		public static function frame() : void
		{
			//begin frame
			//Capture the picture
			var img:BitmapData = ImgAcq.capturePicture();
			//Apply the pre-traitement
			PreProc.apply(img);
			//Detect colors
			ColDetect.detect(img);
			//Transform the detected colors to points
			PointsDetect.detect(img);
			//Give the deteced points to the Recognition object
			Reco.addAll(PointsDetect.points);
			Reco.recognize();
			//end frame
		}
	}
}