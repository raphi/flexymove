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
		
		public function PointsDetection()
		{
			_points = new Array();
		}
		
		//virtual function : assign to a color or color groups a point 

		public function detect(img:BitmapData) : void
		{
			for(var i:int = 0; i < 50; i++) 
				for(var j:int = 10; j < 15; j++) 
					img.setPixel(i,j,255*256*256);
			
		}
	}
}