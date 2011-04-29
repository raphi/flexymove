package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.AbstractConsumer;
	
	public class ColorsDetection
	{
		private var colorsCalibrations:ArrayCollection = null;//array of ColorCalibration
		private var _state:int;/* 0 => in calibration, 1 => calibrated */
		private var _colors:ArrayCollection = null;
		public var _error:String = "no error";

		public function ColorsDetection()
		{
			reset();
		}
		
		public function get colors():ArrayCollection
		{
			return _colors;
		}

		public function set colors(value:ArrayCollection):void
		{
			_colors = value;
		}
		public function reset():void
		{
			_state = 0;
			if (colorsCalibrations != null)
				colorsCalibrations.removeAll();
			else
				colorsCalibrations = new ArrayCollection();
			if (_colors != null)
				_colors.removeAll();
			else
				_colors = new ArrayCollection();

			//blue
			var min:int = 0x003098;
			var max:int = 0x36A4FF;
			min = 0x000050;
			max = 0x36A4FF;
			colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(100,100,40,40)));
			_colors.addItem(-1);
			
			//colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(150,100,40,40)));
			//_colors[1] = -1;
			
			//colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(200,100,40,40)));
			
			//colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(250,100,40,40)));
			
			//colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(300,100,40,40)));
			var calib:ColorCalibration;
			for each(calib in colorsCalibrations)
			{
				calib.reset();
			}
		}
		public function detect(img:BitmapData) : void
		{
			var calib:ColorCalibration;
			if (_state == 0)
			{
				//tets
				
				/////////// APPLYFILTER
				
				
				var p:Point;
				var r:Rectangle;
				var n:int = 0;
				
				// red matrix
				
				/*var m:Array = [
					12,-12,-12,0,0,
					0,0,0,0,0,
					0,0,0,0,0,
					0,0,0,1,0];*/
				// bleu clair
				/*var m:Array = [
					-4,-4,+12,0,0,
					0,0,0,0,0,
					0,0,0,0,0,
					0,0,0,1,0];*/
				//img.applyFilter(img,r,p,new ColorMatrixFilter(m));
				
				
				///////// CONVOLUTION FILTER
				/*
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
				
				//return;
				
				_state = 1;
				for each(calib in colorsCalibrations)
				{
					calib.calibrate(img);
					if (calib.state == 0)
					{
						_state = 0;
					}
					else
					{
						//calibration of color describe by calib suceed
						_colors[n] = calib.range.moyValue;
					}
					_error = calib._error;
					n++;
				}
			}
			else
			{
				r = new Rectangle(0, 0, img.width, img.height);
				p = new Point(0, 0);
				for each(calib in colorsCalibrations)
				{
					img.paletteMap(img, r, p, calib.redArray, calib.greenArray, calib.blueArray);
					img.threshold(img, r, p, '!=', calib.range.moyValue, 0x000000, 0x00FFFFFF);
					break;
				}
			}
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
		}

	}
}