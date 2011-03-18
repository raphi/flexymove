package Movelib.colorsDetection
{
	import flash.display.BitmapData;

	public class ColorsDetection
	{
		private var colorsCalibrations:Array;//array of ColorCalibration

		public function ColorsDetection()
		{
			colorsCalibrations = new Array();
			//reperes detection, five finger and the center of the hand
			colorsCalibrations.push(new ColorCalibration());
			colorsCalibrations.push(new ColorCalibration());
			colorsCalibrations.push(new ColorCalibration());
			colorsCalibrations.push(new ColorCalibration());
			colorsCalibrations.push(new ColorCalibration());
			colorsCalibrations.push(new ColorCalibration());
		}

		public function detect(img:BitmapData) : void
		{
		}
	}
}