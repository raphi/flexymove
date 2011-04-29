package Movelib.Pointsdetection
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;

	public class PointsDetection
	{
		private var _points:Array;
		private var _colors:ArrayCollection = null;
		private var _askForRecalibration:Boolean = false
		
		public function PointsDetection()
		{
			_points = new Array();
		}
		
		//virtual function : assign to a color or color groups a point 

		public function detect(img:BitmapData) : void
		{
			if (_colors[0] == -1)
			{
				return;
			}
			if (_points.length > 20)
			{
				_points.shift();
				//_points = [];
				//_askForRecalibration = true;
			}
			///*
			var i:int;
			var j:int;
			for (i = 0; i < img.width - 1; i++)
			{
				for (j = 0; j < img.height - 1; j++)
				{
					if (img.getPixel(i, j) == 0)
					{
						continue;
					}
					if (img.getPixel(i + 1, j) == 0)
					{
						img.setPixel(i, j, 0);
						continue;
					}
					if (img.getPixel(i, j + 1) == 0)
					{
						img.setPixel(i, j, 0);
						continue;
					}
					if (img.getPixel(i + 1, j + 1) == 0)
					{
						img.setPixel(i, j, 0);
						continue;
					}
				}
			}
			//*/
			var r:Rectangle = img.getColorBoundsRect(0xFFFFFF, _colors[0], true);
			if (r.width < 200 && r.height < 200 && r.width > 10 && r.height > 10)
			{
				_points.push(new Point(r.x + r.width / 2, r.y + r.height / 2));
				img.setPixel(r.left, r.top, 0x00FF00);
				img.setPixel(r.left + 1, r.top + 1, 0x00FF00);

				img.setPixel(r.left, r.bottom, 0x00FF00);
				img.setPixel(r.left + 1, r.bottom - 1, 0x00FF00);
				
				img.setPixel(r.right, r.top, 0x00FF00);
				img.setPixel(r.right - 1, r.top + 1, 0x00FF00);
				img.setPixel(r.right, r.bottom, 0x00FF00);
				img.setPixel(r.right - 1, r.bottom - 1, 0x00FF00);
			}
			for each(var p:Point in _points)
			{
				img.setPixel(p.x, p.y, 0xFF0000);
				///*
				img.setPixel(p.x - 1, p.y, 0xFF0000);
				img.setPixel(p.x, p.y - 1, 0xFF0000);
				img.setPixel(p.x + 1, p.y, 0xFF0000);
				img.setPixel(p.x, p.y + 1, 0xFF0000);
				//*/
			}
		}
		public function get colors():ArrayCollection
		{
			return _colors;
		}
		
		public function set colors(value:ArrayCollection):void
		{
			_colors = value;
		}
		
		public function get points():Array
		{
			return _points;
		}

		public function get askForRecalibration():Boolean
		{
			return _askForRecalibration;
		}

		public function set askForRecalibration(value:Boolean):void
		{
			_askForRecalibration = value;
		}

	}
}