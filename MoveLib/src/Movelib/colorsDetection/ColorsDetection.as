package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
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
			var min:int = 0x000050;
			var max:int = 0x36A4FF;
			min = 0x000040;
			max = 0x36A4FF;
			//colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(100,100,40,40)));
			//_colors.addItem(-1);
			
			min = 0x000000;
			max = 0xFFA0A0;
			colorsCalibrations.addItem(new ColorCalibration(new ColorRange(min, max), new Rectangle(220,100,40,40)));
			_colors.addItem(-1);
			
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
				_state = 1;
				var n:int = 0;
				for each(calib in colorsCalibrations)
				{
					_error = calib._error;
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
				var p:Point = new Point(0, 0);
				var r:Rectangle = new Rectangle(0, 0, img.width, img.height);
				for each(calib in colorsCalibrations)
				{
					img.paletteMap(img, r, p, calib.redArray, calib.greenArray, calib.blueArray);
					img.threshold(img, r, p, '!=', calib.range.moyValue, 0x000000, 0x00FFFFFF);
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