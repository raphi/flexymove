package Movelib.colorsDetection
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ColorCalibration
	{
		private var _range:ColorRange;
		private var _redArray:Array = new Array(256);
		private var _greenArray:Array = new Array(256);
		private var _blueArray:Array = new Array(256);
		private var _areaDetection:Rectangle;
		private var _state:int = 0;/* 0 => in calibration, 1 => calibrated*/
		
		public function ColorCalibration(cr:ColorRange, areaDetection:Rectangle)
		{
			_range = cr;
			_areaDetection = areaDetection;
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
			
			for(var i:uint = 0; i <= 255; i++)
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
		
		//Calibrates the rangeColor using a BitmapData
		public function calibrate(img:BitmapData) : void
		{
			if (_state != 0)/* not in calibration */
			{
				return;
			}
			//img.fillRect(_areaDetection, 255);
			var area:BitmapData = new BitmapData(img.width, img.height);
			area.draw(img,null,null,null,_areaDetection);
			img.setPixel(_areaDetection.x,_areaDetection.y, 255);
			img.setPixel(_areaDetection.x + 1,_areaDetection.y, 255);
			img.setPixel(_areaDetection.x + 2,_areaDetection.y, 255);
			img.setPixel(_areaDetection.x + 3,_areaDetection.y, 255);
			img.setPixel(_areaDetection.x + 4,_areaDetection.y, 255);
			img.setPixel(_areaDetection.x + 5,_areaDetection.y, 255);
			img.setPixel(_areaDetection.x + 6,_areaDetection.y, 255);
			
			img.setPixel(_areaDetection.x,_areaDetection.y + 1, 255);
			img.setPixel(_areaDetection.x,_areaDetection.y + 2, 255);
			img.setPixel(_areaDetection.x,_areaDetection.y + 3, 255);
			img.setPixel(_areaDetection.x,_areaDetection.y + 4, 255);
			img.setPixel(_areaDetection.x,_areaDetection.y + 5, 255);
			img.setPixel(_areaDetection.x,_areaDetection.y + 6, 255);
			var p:Point = new Point(_areaDetection.x, _areaDetection.y);
			img.paletteMap(img, _areaDetection, p, _redArray, _greenArray, _blueArray);
			img.threshold(img, _areaDetection, p, '!=', _range.moyValue, 0x000000, 0xFFFFFF);
			var n:int = 0;
			for (var i:int = _areaDetection.x; i < _areaDetection.right; i++)
			{
				for (var j:int = _areaDetection.y; j < _areaDetection.bottom; j++)
				{
					if (img.getPixel(i,j) == _range.moyValue)
					{
						n++;
					}
				}
			}
			if (n > 200 && n < 50*30)
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
				for (i = _areaDetection.x; i < _areaDetection.right; i++)
				{
					for (j = _areaDetection.y; j < _areaDetection.bottom; j++)
					{
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