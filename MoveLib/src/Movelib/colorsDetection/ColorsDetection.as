package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ColorsDetection
	{
		private var colorsCalibrations:Array;//array of ColorCalibration
		private var _state:int = 0;/* 0 => in calibration, 1 => calibrated */
		private var _n:int = 0;

		public function ColorsDetection()
		{
			colorsCalibrations = new Array();
			//reperes detection, five finger and the center of the hand
			//red
			colorsCalibrations.push(new ColorCalibration(new ColorRange(0xA00000, 0xFF8090), new Rectangle(100,80,50,50)));
			//green
			colorsCalibrations.push(new ColorCalibration(new ColorRange(0x00A000, 0x80FF80), new Rectangle(150,80,50,50)));
			//blue
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x003496, 0x3AA4FF), new Rectangle(200,80,50,50)));
			//white
			//colorsCalibrations.push(new ColorCalibration(new ColorRange(0x0000A0, 0x8080FF), new Rectangle(200,80,50,50)));
		}
		
		public function detect(img:BitmapData) : void
		{
			var calib:ColorCalibration;
			if (_state == 0)
			{
				//tets
				
				/////////// APPLYFILTER
				
				/*
				
				var p:Point = new Point(img.width / 2,0);
				var r:Rectangle = new Rectangle(0, 0, img.width, img.height);
				// red matrix
				
				var m:Array = [
					12,-12,-12,0,0,
					0,0,0,0,0,
					0,0,0,0,0,
					0,0,0,1,0];
				// bleu clair
				var m:Array = [
					-4,-4,+12,0,0,
					0,0,0,0,0,
					0,0,0,0,0,
					0,0,0,1,0];
				//img.applyFilter(img,r,p,new ColorMatrixFilter(m));
				
				
				///////// CONVOLUTION FILTER
				
				var clamp:Boolean = false;
				var clampColor:Number = 0xFF0000;
				var clampAlpha:Number = 1;
				
				var bias:Number = 0;
				var preserveAlpha:Boolean = false;
				var matrixCols:Number = 3;
				var matrixRows:Number = 3;
				var matrix:Array = [ -1,0,-1,
					-1,5,-1,
					0,-1,0 ];
				
				var filter:ConvolutionFilter = new ConvolutionFilter(matrixCols, matrixRows, matrix, matrix.length, bias, preserveAlpha, clamp, clampColor, clampAlpha);
				img.applyFilter(img, r, p, filter);
				matrix = [ -2,-1,0,
					-1,1,1,
					0,1,2 ];

				filter = new ConvolutionFilter(matrixCols, matrixRows, matrix, matrix.length, bias, preserveAlpha, clamp, clampColor, clampAlpha);
				img.applyFilter(img, r, p, filter);
				
				*/
				
				
				
				
				_state = 1;
				for each(calib in colorsCalibrations)
				{
					if (calib.state == 0)
					{
						calib.calibrate(img);
						_state = 0;
					}
				}
			}
			else
			{
				var res:BitmapData = new BitmapData(img.width, img.height, true, 0x00000000);
				for each(calib in colorsCalibrations)
				{
					if (calib.state == 0)
					{
						calib.calibrate(res);
					}
					else
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
				}
				img.fillRect(r, 0xFFFFFFFF);
				img.draw(res);
				res.dispose();
			}
		}
	}
}