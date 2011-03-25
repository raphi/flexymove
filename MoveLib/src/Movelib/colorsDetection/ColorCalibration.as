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
			/*img.threshold(img, rect, p, '>=', _r_max * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '>=', _g_max * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '>=', _b_max, 0x000000, 0x0000ff);
			
			img.threshold(img, rect, p, '<=', _r_min * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '<=', _g_min * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '<=', _b_min, 0x000000, 0x0000ff);*/
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