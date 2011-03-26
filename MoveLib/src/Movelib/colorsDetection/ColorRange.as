package Movelib.colorsDetection
{
	public class ColorRange
	{
		private var _minValue:int = 0;
		private var _maxValue:int = 0;
		private var _moyValue:int = 0;
		public function ColorRange(minValue:int, maxValue:int)
		{
			_minValue = minValue;
			_maxValue = maxValue;
			calculMoy();
		}
		
		public function calculMoy() : void
		{
			_moyValue = ((((_maxValue & 0xFF0000) + (_minValue & 0xFF0000)) / 2) & 0xFF0000) +
				((((_maxValue & 0x00FF00) + (_minValue & 0x00FF00)) / 2) & 0x00FF00)  +
				((((_maxValue & 0x0000F) + (_minValue & 0x0000FF)) / 2)  & 0x0000FF);
			_moyValue = 0xFF0000;
		}

		public function get moyValue():int
		{
			return _moyValue;
		}

		public function set moyValue(value:int):void
		{
			_moyValue = value;
		}

		public function get maxValue():int
		{
			return _maxValue;
		}

		public function set maxValue(value:int):void
		{
			_maxValue = value;
		}

		public function get minValue():int
		{
			return _minValue;
		}

		public function set minValue(value:int):void
		{
			_minValue = value;
		}

	}
}