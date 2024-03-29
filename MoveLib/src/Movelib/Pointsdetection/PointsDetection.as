package Movelib.Pointsdetection
{
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;

	public class PointsDetection
	{
		private var _points:Array;// one detected point by finger
		private var _colors:ArrayCollection = null;// one color for each finger
		private var _askForRecalibration:Boolean = false;
		private var _oldRectangleWidth:int = -1;
		private var _oldRectangleHeight:int = -1;
		
		public function PointsDetection()
		{
			_points = new Array();
		}
		
		//virtual function : assign to a color or color groups a point 

		public function detect(img:BitmapData):void
		{
			var color:int;
			var n:int;
			var i:int;
			var j:int;
			var r:Rectangle;
			img.applyFilter(img, new Rectangle(0, 0, img.width, img.height), new Point(0, 0), new BlurFilter(2, 2));
			_points = [];
			for (n = 0; n < _colors.length; n++)
			{
				color = _colors[n];
				if (color == -1)
				{
					continue;
				}
				_points[n] = null;
				r = img.getColorBoundsRect(0xFFFFFF, color, true);
				if (_oldRectangleWidth == -1 || (r.width < 4 * _oldRectangleWidth && r.width > 0.2 * _oldRectangleWidth))
				{
					if (r.width > 0 && r.height > 0)
		 			{
						_oldRectangleWidth = r.width;
						_oldRectangleHeight = r.height;
						
						_points[n] = new Point(r.x + r.width / 2, r.y + r.height / 2);
						img.setPixel(r.left, r.top, 0x00FF00);
						img.setPixel(r.left + 1, r.top, 0x00FF00);
						img.setPixel(r.left, r.top + 1, 0x00FF00);
						img.setPixel(r.left + 2, r.top, 0x00FF00);
						img.setPixel(r.left, r.top + 2, 0x00FF00);
						
						img.setPixel(r.left, r.bottom, 0x00FF00);
						img.setPixel(r.left + 1, r.bottom, 0x00FF00);
						img.setPixel(r.left, r.bottom - 1, 0x00FF00);
						img.setPixel(r.left + 2, r.bottom, 0x00FF00);
						img.setPixel(r.left, r.bottom - 2, 0x00FF00);
						
						img.setPixel(r.right, r.top, 0x00FF00);
						img.setPixel(r.right - 1, r.top, 0x00FF00);
						img.setPixel(r.right, r.top + 1, 0x00FF00);
						img.setPixel(r.right - 2, r.top, 0x00FF00);
						img.setPixel(r.right, r.top + 2, 0x00FF00);
						
						img.setPixel(r.right, r.bottom, 0x00FF00);
						img.setPixel(r.right - 1, r.bottom, 0x00FF00);
						img.setPixel(r.right, r.bottom - 1, 0x00FF00);
						img.setPixel(r.right - 2, r.bottom, 0x00FF00);
						img.setPixel(r.right, r.bottom - 2, 0x00FF00);
					}
				}
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