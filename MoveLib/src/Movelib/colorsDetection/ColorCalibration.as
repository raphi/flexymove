package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ColorCalibration
	{
		private var _initialRange:ColorRange;
		private var _range:ColorRange;
		private var _redArray:Array = new Array(256);
		private var _greenArray:Array = new Array(256);
		private var _blueArray:Array = new Array(256);
		private var _areaDetection:Rectangle;
		private var _state:int/* 0 => in calibration, 1 => calibrated*/
		public var _error:String = "no error";
		
		public function ColorCalibration(cr:ColorRange, areaDetection:Rectangle)
		{
			_areaDetection = areaDetection;
			_initialRange = cr;
			reset();
			//_range = new ColorRange(_initialRange.minValue, _initialRange.maxValue);
		}
		public function reset():void
		{
			_state = 0;
			_range = new ColorRange(_initialRange.minValue, _initialRange.maxValue);
			CalculColors();
		}
		public function CalculColors() : void
		{
			var rmin:int = (_range.minValue & 0xFF0000) / (256*256);
			var rmax:int = (_range.maxValue & 0xFF0000) / (256*256);
			var rmoy:int = _range.moyValue & 0xFF0000;

			var gmin:int = (_range.minValue & 0x00FF00) / 256;
			var gmax:int = (_range.maxValue & 0x00FF00) / 256;
			var gmoy:int = _range.moyValue & 0x00FF00;

			var bmin:int = _range.minValue & 0x0000FF;
			var bmax:int = _range.maxValue & 0x0000FF;
			var bmoy:int = _range.moyValue & 0x0000FF;

			for(var i:uint = 0; i < 256; i++)
			{
				if ((rmin <= i) && (i <= rmax))
					_redArray[i] = rmoy;
				else
					_redArray[i] = i*256*256
				
				if ((gmin <= i) && (i <= gmax))
					greenArray[i] = gmoy;
				else
					greenArray[i] = i*256;
				
				if ((bmin <= i) && (i <= bmax))
					_blueArray[i] = bmoy;
				else
					blueArray[i] = i;
				
			}
		}
		public function drawRectangleBorder(img:BitmapData, c:int) : void
		{
			var i:int;
			var j:int;
			for (i = _areaDetection.left; i < _areaDetection.right; i++)
			{
				img.setPixel(i, _areaDetection.top - 1, c);
				img.setPixel(i, _areaDetection.top - 2, c);
				img.setPixel(i, _areaDetection.bottom, c);
				img.setPixel(i, _areaDetection.bottom + 1, c);
			}
			for (j = _areaDetection.top; j < _areaDetection.bottom; j++)
			{
				img.setPixel(_areaDetection.left - 1, j, c);
				img.setPixel(_areaDetection.left - 2, j, c);
				img.setPixel(_areaDetection.right, j, c);
				img.setPixel(_areaDetection.right + 1, j, c);
			}
		}
		
		//Calibrates the rangeColor using a BitmapData
		public function calibrate(img:BitmapData) : void
		{
			if (_state != 0)/* not in calibration */
			{
				drawRectangleBorder(img, 0xAAAAAA);
				return;
			}
			drawRectangleBorder(img, 0xFFFFFF);
			//test
			var n:int = 0;
			var j:int = 0;
			var i:int = 0;
			var area:BitmapData = new BitmapData(img.width, img.height);
			area.draw(img, null, null, null, _areaDetection);
			
			var p:Point = new Point(_areaDetection.x, _areaDetection.y);
			img.paletteMap(img, _areaDetection, p, _redArray, _greenArray, _blueArray);
			img.threshold(img, _areaDetection, p, '!=', _range.moyValue, 0x000000, 0xFFFFFF);
			
			for (i = _areaDetection.x + _areaDetection.width / 4; i < _areaDetection.right - _areaDetection.width / 4; i++)
			{
				for (j = _areaDetection.y + _areaDetection.height / 4; j < _areaDetection.bottom - _areaDetection.height / 4; j++)
				{
					if (img.getPixel(i,j) == _range.moyValue)
					{
						n++;
					}
				}
			}
			
			//_error = n + " pixels détectés";
			//if (n > 20*20 && n < 50*30)
			if (n > 160)
			{
				_state = 1;
				var pixel:int = 0;
				var r:int;
				var g:int;
				var b:int;
				var rmin:int = 255;
				var gmin:int = 255; 
				var bmin:int = 255;
				
				var rmax:int = 0; 
				var gmax:int = 0; 
				var bmax:int = 0; 
				/*
				for (i = _areaDetection.x; i < _areaDetection.right; i++)
				{
					for (j = _areaDetection.y; j < _areaDetection.bottom; j++)
					{
				*/
				//just to test
				for (i = _areaDetection.x + _areaDetection.width / 4; i < _areaDetection.right - _areaDetection.width / 4; i++)
				{
					for (j = _areaDetection.y + _areaDetection.height / 4; j < _areaDetection.bottom - _areaDetection.height / 4; j++)
					{
				//end of just to test
						if (img.getPixel(i, j) == _range.moyValue)
						{
							pixel = area.getPixel(i, j);
							r = (pixel & 0xFF0000) / (256 * 256);
							g = (pixel & 0x00FF00) / 256;
							b = pixel & 0x0000FF;
							if (r < rmin)
								rmin = r;
							if (r > rmax)
								rmax = r;

							if (g < gmin)
								gmin = g;
							if (g > gmax)
								gmax = g;

							if (b < bmin)
								bmin = b;
							if (b > bmax)
								bmax = b;
						}
					}
				}
				_range.minValue = rmin * 256 * 256 + gmin * 256 + bmin;
				_range.maxValue = rmax * 256 * 256 + gmax * 256 + bmax;
				_range.calculMoy();
				CalculColors();
			}
			area.dispose();
		}

		public function get redArray():Array
		{
			return _redArray;
		}

		public function get greenArray():Array
		{
			return _greenArray;
		}

		public function get blueArray():Array
		{
			return _blueArray;
		}

		public function get range():ColorRange
		{
			return _range;
		}

		public function set range(value:ColorRange):void
		{
			_range = value;
		}

		public function get state():int
		{
			return _state;
		}



	}
}