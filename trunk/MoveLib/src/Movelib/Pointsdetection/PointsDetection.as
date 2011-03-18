package Movelib.Pointsdetection
{
	import flash.display.BitmapData;
	import flash.geom.Point;

	public class PointsDetection
	{
		private var _points:Array;
		
		public function get points():Array
		{
			return _points;
		}
		
		public function set points(value:Array):void
		{
			_points = value;
		}

		public function PointsDetection()
		{
			_points = new Array();
		}
		
		//virtual function : assign to a color or color groups a point 

		public function detect(img:BitmapData) : void
		{
			
		}
	}
}