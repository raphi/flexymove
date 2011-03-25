package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import spark.components.supportClasses.Range;
	
	public class ColorsDetection
	{
		private var colorsCalibrations:Array;//array of ColorCalibration
		
		public function ColorsDetection()
		{
			colorsCalibrations = new Array();
			//reperes detection, five finger and the center of the hand
			colorsCalibrations.push(new ColorCalibration(new ColorRange(0x8F0000, 0xFF6B39)));
			colorsCalibrations.push(new ColorCalibration(new ColorRange(0x0000D0, 0x5050FF)));
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x8F0000, 0xFF6B39)));
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x8F0000, 0xFF6B39)));
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x8F0000, 0xFF6B39)));
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x8F0000, 0xFF6B39)));
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x8F0000, 0xFF6B39)));
		}
		
		public function detect(img:BitmapData) : void
		{
			var res:BitmapData = new BitmapData(img.width, img.height, true, 0x00000000);
			var calib:ColorCalibration;
			for each(calib in colorsCalibrations)
			{
				var _img:BitmapData = new BitmapData(img.width, img.height, true, 0xFFFFFFFF);
				_img.draw(img);
				var r:Rectangle = new Rectangle(0, 0, _img.width, _img.height);
				var p:Point = new Point(0, 0);
				_img.paletteMap(_img, r, p, calib.redArray, calib.greenArray, calib.blueArray);
				_img.threshold(_img, r, p, '!=', calib.range.moyValue, 0x000000, 0x00FFFFFF);
				res.draw(_img);
				_img.dispose();
			}
			img.fillRect(r, 0xFFFFFFFF);
			img.draw(res);
			res.dispose();
		}
	}
}