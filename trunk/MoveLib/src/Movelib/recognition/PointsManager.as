
package Movelib.recognition
{
	public class PointsManager
	{
		private var _points:Array;
		
		public function PointsManager()
		{
			_points = new Array();
		}
		
		/** "élagage" in French : prune the point array */ 
		public function prunning():void
		{
		
		}
		public function addAll(points:Array):void 
		{
			_points = _points.concat(points);
			if (_points.length > 20)
				_points.shift();
		}
		public function getPoint():Array
		{
			return _points;
		}
	}
}