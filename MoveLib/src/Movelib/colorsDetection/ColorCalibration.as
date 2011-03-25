package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	
	public class ColorCalibration
	{
		private var range:ColorRange;
		
		public function ColorCalibration(cr:ColorRange = null)
		{
			if (cr == null)
				range = new ColorRange(0, 0);
			else
				range = cr;
		}
		
		//Calibrates the rangeColor using a BitmapData
		public function calibrate(img:BitmapData) : void
		{
			for(var i:int = 0; i < img.width; i++)
			{
				for(var j:int = 0; j < img.height; j++)
				{
					if (range.isIn(img.getPixel(i,j)))
					{
						
					}
				}
			}
		}
	}
}