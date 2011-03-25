package Movelib
{
	import Movelib.colorsDetection.ColorRange;

	public class Landmark
	{
		private var _fingerType:String;//a string who describe the finger
		private var _range:ColorRange;//a large color range to detect the color into a small area
		private var _color:int;//a particular color
		//more explanation for this class
		/**
		 * When the program begins, the ColorsDetection class must calibrate itself. 
		 * For that, we have a large range of colors (The Landmark._range).
		 * For example, if we want to detect a red finger, we give a large range
		 * of red color, the ColorCalibration search on a small and specific area (look at the image below).
		 * _______________
		 * |              |
		 * |   _          |
		 * |  |_|         |
		 * |              |
		 * |              |
		 * |______________|
		 * 
		 * 
		 * The user must put his/her red finger into the small area, and the ColorCalibration
		 * will detect all pixels (into the small area) who match the large range. With
		 * all detected pixels, the ColorCalibration will generate a new ColorRange very smaller
		 * that we will use to detect all red pixel on the entire image.  
		 * 
		 * 
		 * */
		
		public function Landmark(color:int, fingerType:String, range:ColorRange)
		{
			_color = color;
			_fingerType = fingerType;
			_range = range;
		}

		public function get range():ColorRange
		{
			return _range;
		}

		public function set range(value:ColorRange):void
		{
			_range = value;
		}

		public function get fingerType():String
		{
			return _fingerType;
		}

		public function set fingerType(value:String):void
		{
			_fingerType = value;
		}

		public function get color():int
		{
			return _color;
		}

		public function set color(value:int):void
		{
			_color = value;
		}

	}
}