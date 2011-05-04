
package Movelib.recognition
{
	import flash.geom.Point;
	
	
	public class PointsManager
	{
		private var _points:Array;//array of array of points
		private var directionArray:Array;
		
		
		public var _error:String = "";
		public var _detectionInfo:String = "";
			
		public var mvtDetected:Boolean = false;
		public var velocity:Number = -1;
		public var currentdirection:int = 0;
		
		public function PointsManager()
		{
			_points = new Array();
			_points[0] = new Array();
			directionArray = new Array();
		}
		
		public function mvtProcess():void
		{
			mvtDetected = false;
			velocity = -1;
			currentdirection = 0;
		}
		
		public function reset():void
		{
			_points[0] = [];
		}
		/** "élagage" in French : prune the point array */ 
		public function prunning():void
		{
			mvtDetected = true;
			var sequenceLength:int = _points[0].length - 1;
			
			//Velocity Cal Find a goo equation
		//	var origineX:int = _points[0][0].x;
		//	var endX:int = _points[0][_points.length - 2].x;
			velocity = 0;
			
			currentdirection = directionArray[0];
			_error += "direction" + currentdirection+ "\n";
			var newArray:Array = new Array();
			newArray.push(_points[0][ _points[0].length - 1]);
			
			_points[0] = newArray;
		}

		/**Analyse Direction with old Point and Add it in Array*/
		public function createVector():void
		{
			if (_points[0].length > 1)
			{
				
				//Change it to check all finger
				var originPoint:Point = _points[0][_points[0].length - 2];
				var endPoint:Point =  _points[0][_points[0].length - 1];
				
				
				var noriginPoint:Point = originPoint;
				var nendPoint:Point =  endPoint;
				if (originPoint.x > endPoint.x)
				{
					var tmp:Point = originPoint;
					noriginPoint = endPoint;
					nendPoint = tmp;
				}
					
				var direction:int = 0;
				var coef:Number = (noriginPoint.y - nendPoint.y) / (noriginPoint.x -  nendPoint.x);
				_detectionInfo += "pt1 " + noriginPoint.x + " " + noriginPoint.y + "\n";
				_detectionInfo += "pt2 " + nendPoint.x + " " + nendPoint.y + "\n";
				
				//Get direction from Coef
				if (coef > 1.5)
					direction = 4;
				else if (coef > 0.5)
					direction = 3;
				else if (coef > -0.5)
					direction = 2;
				else if (coef > -1.5)
					direction = 1;
				else 
					direction = 0;
				
				if(endPoint.x < originPoint.x)
					switch(direction)
					{
						case 0:{direction = 4;break;}
						case 1:{direction = 5;break;}
						case 2:{direction = 6;break;}
						case 3:{direction = 7;break;}
						case 4:{direction = 0;break;}	
						default:{break;}
					}
				//Add direction in Array
				directionArray.push(direction);
				_detectionInfo += "direction " + direction +" "+coef +"\n";
				
				
				const directionArrayLength:int = directionArray.length;
				//If last Direction Add is not a continuity of previous mouvment(replace by is a aknown mvt)
				if (directionArrayLength >=2 && (directionArray[directionArrayLength - 1] != directionArray[directionArrayLength - 2]))
				{
					prunning();
					return;
				}
			}
			return;	
		}
		

		public function addDetectedPoints(points:Array):void 
		{
		/*
		 * if (myVal >= val1 && myVal <= val2)
					return true;
					return false;*/
			
			if (points[0] != null)

			{
				if (_points[0].length > 0)
				{
					//PB plusieur fois le meme point A changer
					if((_points[0][_points[0].length - 1].x != points[0].x) &&
						(_points[0][_points[0].length - 1].y != points[0].y))
					{
						_points[0].push(points[0]);
						
						//_error += points[0].x + " " + points[0].y+"\n";
						createVector();
					}
					
				}
				else
					_points[0].push(points[0]);
			}
			/*if (_points[0].length > 20)
			{
				delete(_points[0].shift());
			}*/

		}
		
		
		public function getPoint():Array
		{
			return _points[0];
		}
	}
}