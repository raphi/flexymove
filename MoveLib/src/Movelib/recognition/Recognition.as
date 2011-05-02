package Movelib.recognition
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class Recognition
	{
		private var _points:PointsManager;
		public var _error:String = "pas d'erreur";
		public var _detectionInfo:String = "pas d'erreur";
		public function Recognition()
		{
			_points = new PointsManager();
		}
		
		public function addAll(points:Array) : void
		{
			
			_points.addAll(points);
			
		}
		
		/** recognize a mouvement from a point list */
		public function recognize(img:BitmapData) : void
		{
			
			for each(var p:Point in _points.getPoint())
			{
				img.setPixel(p.x, p.y, 0xFF0000);
				img.setPixel(p.x - 1, p.y, 0xFF0000);
				img.setPixel(p.x, p.y - 1, 0xFF0000);
				img.setPixel(p.x + 1, p.y, 0xFF0000);
				img.setPixel(p.x, p.y + 1, 0xFF0000);
			}
			_detectionInfo = " ";
			_error  = _points._error;
			_detectionInfo = _points._detectionInfo;
			
			for each(var p1:Point in _points.getPoint())
			{
				_error += "\n"+ p1.x + " " + p1.y; 
				
			}
		}
	}
}