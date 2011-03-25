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
		
		public function ColorCalibration(cr:ColorRange = null)
		{
			if (cr == null)
				range = new ColorRange(0, 0);
			else
				range = cr;
			var rmin:int = (cr.minValue & 0xFF0000) / (256*256);
			var rmax:int = (cr.maxValue & 0xFF0000) / (256*256);
			var rmoy:int = cr.moyValue & 0xFF0000;

			var gmin:int = (cr.minValue & 0x00FF00) / 256;
			var gmax:int = (cr.maxValue & 0x00FF00) / 256;
			var gmoy:int = cr.moyValue & 0x00FF00;

			var bmin:int = cr.minValue & 0x0000FF;
			var bmax:int = cr.maxValue & 0x0000FF;
			var bmoy:int = cr.moyValue & 0x0000FF;
			
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
		}

		public function get redArray():Array
		{
			return _redArray;
		}

		public function set redArray(value:Array):void
		{
			_redArray = value;
		}

		public function get greenArray():Array
		{
			return _greenArray;
		}

		public function set greenArray(value:Array):void
		{
			_greenArray = value;
		}

		public function get blueArray():Array
		{
			return _blueArray;
		}

		public function set blueArray(value:Array):void
		{
			_blueArray = value;
		}

		public function get range():ColorRange
		{
			return _range;
		}

		public function set range(value:ColorRange):void
		{
			_range = value;
		}


	}
}