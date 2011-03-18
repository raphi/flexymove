package Movelib.colorsDetection
{
	import flash.display.BitmapData;

	public class ColorCalibration
	{
		private var range:ColorRange;
		
		public function ColorCalibration()
		{
			 range = new ColorRange(0, 0);
		}
		
		//Calibrates the rangeColor using a BitmapData
		public function calibrate(img:BitmapData) : void
		{
		
		}
	}
}