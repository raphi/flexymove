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
			
		}
		public function isIn(color:int) : Boolean
		{
			if (((_minValue & 0xFF0000) < (color & 0xFF0000)) && 
				((_minValue & 0x00FF00) < (color & 0x00FF00)) && 
				((_minValue & 0x0000FF) < (color & 0x0000FF)) &&
				((_maxValue & 0xFF0000) > (color & 0xFF0000)) && 
				((_maxValue & 0x00FF00) > (color & 0x00FF00)) && 
				((_maxValue & 0x0000FF) > (color & 0x0000FF)))
				return true;
			else
				return false;
		}
	}
}