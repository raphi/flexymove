
package Movelib.recognition
{
	import flash.geom.Point;
	
	public class PointsManager
	{
		private var _points:Array;//array of array of points
		public var _error:String = "PointsManager";
		public var _detectionInfo:String = "";
		private const nbMinPointsToAnalyse:int = 3;
		private const uncertaintyA:Number = 0.5;
		private const uncertaintyB:Number = 3;
		public function PointsManager()
		{
			
			_points = new Array();
			_points[0] = new Array();
		}
		
		/** "élagage" in French : prune the point array */ 
		public function prunning():void
		{
			_error = "recon\n";
			_detectionInfo = "recon\n";
			var n:int = 0;
			var index:int;
			var hasdel:int;
			var currentPoint:Point;
			var currentA:Number;
			var currentB:Number;
			for (n = 0; n < _points.length; n++)
			{
				index = -1;
				hasdel = 0;
				if(_points[0].length > nbMinPointsToAnalyse)
				{
					currentPoint = _points[n][0];
					currentA = 0;
					currentB = 0;
					
					_detectionInfo += i + " x " + _points[n][i].x +"y " + _points[i].y + "\n";
					_detectionInfo += "First \n";
					for(var i:int = 1; i < _points[n].length; i++)
					{
						if (hasdel == 1)
							hasdel++;
						else if (hasdel == 2)
						{
							hasdel =0;
							index++;
						}
						index++;
						var goodPoint:Boolean = false;
						_detectionInfo += i + " x " + _points[n][i].x +"y " + _points[i].y + "\n";
						/*cacul  a and b ob y=ax+b*/
						var a:Number = (currentPoint.y -  _points[n][i].y) / ((currentPoint.x -  _points[i].x));
						var b:Number = currentPoint.y - a*currentPoint.x;
						_error +=i+ " y="+a+"x+"+b+"\n" ;
						if(currentA != 0 && currentA != 0)
						{
							if(between(a,currentA-uncertaintyA,currentA+uncertaintyA) &&
								between(b,currentB-uncertaintyB,currentB+uncertaintyB))
							{
								var aPrev:Number = (_points[n][index].y -  _points[n][i].y) / ((_points[n][index].x -  _points[n][i].x));
								var bPrev:Number = currentPoint.y - aPrev*currentPoint.x;
								if ((aPrev >= 0 && a >=0)|| (aPrev <= 0 && a <=0)){
									/**Point GOOD supprimé de la liste*/
									_detectionInfo += "pass "+ index +" "+ aPrev + " "+ bPrev+" GOOD \n";
									goodPoint = true;
								}
								else
								{
									_detectionInfo += "pass "+ index +" "+ aPrev + " "+ bPrev+" BAD\n";
								}
							}
							/*Last point maybe  is a change direction*/
							if(!goodPoint)
								if (i == _points[n].length - 1)
								{
									_detectionInfo += "Last (Change Direction??) \n" 	
									break;
								}
								else
								{
									index--;
									hasdel++;
									_detectionInfo += " del \n" 
								}
						}
						else
						{
							currentA = a;
							currentB = b;
							_detectionInfo += "Second \n"
						}
					}
				}
			}
		}
		
		
		public function between(myVal:Number,val1:Number, val2:Number):Boolean
		{
			if (myVal >= val1 && myVal <= val2)
				return true;
			return false;
		}
		public function addAll(points:Array):void 
		{
			if (points[0] != null)
				_points[0].push(points[0]);
		}
		public function getPoint():Array
		{
			return _points[0];
		}
	}
}