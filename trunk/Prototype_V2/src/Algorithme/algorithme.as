package Algorithme
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import mx.controls.Alert;
	import mx.core.BitmapAsset;

	public class algorithme
	{
		public var _r_min:int;
		public var _r_max:int;
		public var _g_min:int;
		public var _g_max:int;
		public var _b_min:int;
		public var _b_max:int;
		public var _h:int;
		public var _w:int;
		public var taille:int = 0;
		public function algorithme()
		{
		}
		public function ProcessImage(img:BitmapData) : Point
		{
			return new Point(-1,-1);
		}
		public function prepare() : void
		{
		}
		public function get r_min():int
		{
			return _r_min;
		}

		public function set r_min(value:int):void
		{
			_r_min = value;
		}

		public function get r_max():int
		{
			return _r_max;
		}

		public function set r_max(value:int):void
		{
			_r_max = value;
		}

		public function get g_min():int
		{
			return _g_min;
		}

		public function set g_min(value:int):void
		{
			_g_min = value;
		}

		public function get g_max():int
		{
			return _g_max;
		}

		public function set g_max(value:int):void
		{
			_g_max = value;
		}

		public function get b_min():int
		{
			return _b_min;
		}

		public function set b_min(value:int):void
		{
			_b_min = value;
		}

		public function get b_max():int
		{
			return _b_max;
		}

		public function set b_max(value:int):void
		{
			_b_max = value;
		}

		public function get h():int
		{
			return _h;
		}

		public function set h(value:int):void
		{
			_h = value;
		}

		public function get w():int
		{
			return _w;
		}

		public function set w(value:int):void
		{
			_w = value;
		}
		
		
	}
}