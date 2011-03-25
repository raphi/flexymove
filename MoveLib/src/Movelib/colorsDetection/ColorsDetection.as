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
			var calib:ColorCalibration;
			for each(calib in colorsCalibrations)
			{
				calib.calibrate(img);
			}
			for(var i:int = 0; i < 50; i++) 
				for(var j:int = 5; j < 10; j++) 
					img.setPixel(i,j,255*256);
		}
	}
}