package Algorithme
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.controls.Alert;

	public class alpha extends algorithme
	{
		public function alpha()
		{
		}
		override public function ProcessImage(img:BitmapData) : Point
		{
			return searchColor(img, 0);
		}
		override public function prepare() : void
		{
			
		}
		private function searchColor(img:BitmapData, color:int) : Point
		{
			var i:int;
			var j:int;
			var point:Point = new Point(0, 0);
			taille = 0;
			
			/* version basique */
			//var min:int = _r_min*256*256 + _g_min*256 + _b_min;
			//var max:int = _r_max*256*256 + _g_max*256 + _b_max;
			var rect:Rectangle = new Rectangle(0, 0, img.width, img.height);
			var p:Point = new Point(0, 0);
			/*
			var ct:ColorTransform = new ColorTransform(1,
				1,
				1,
				1,
				-33, -124, -230, 0);
			img.colorTransform(rect, ct);
			ct = new ColorTransform(
				255 / (56 - 33),
				255 / (160 - 124),
				255 / (255 - 230),
				1,
				0, 0, 0, 0);
			img.colorTransform(rect, ct);
			*/
			/*
			var ct:ColorTransform = new ColorTransform(1,
				1,
				1,
				1,
				-_r_min, -_g_min, -_b_min, 0);
			img.colorTransform(rect, ct);
			ct = new ColorTransform(1,
				1,
				1,
				1,
				_r_min, _g_min, _b_min, 0);
			img.colorTransform(rect, ct);
			ct = new ColorTransform(1,
				1,
				1,
				1,
				_r_max - 255, _g_max - 255, _b_max - 255, 0);
			img.colorTransform(rect, ct);
			ct = new ColorTransform(1,
				1,
				1,
				1,
				-_r_max + 255, -_g_max + 255, -_b_max + 255, 0);
			img.colorTransform(rect, ct);
			//*/
			img.threshold(img, rect, p, '>=', _r_max * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '>=', _g_max * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '>=', _b_max, 0x000000, 0x0000ff);

			img.threshold(img, rect, p, '<=', _r_min * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '<=', _g_min * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '<=', _b_min, 0x000000, 0x0000ff);
			i = 0;
			var width:int = img.width;
			var height:int = img.height;
			while (i < width)
			{
				j = 0;
				while (j < height)
				{
					//var RGB:int = img.getPixel(i, j);
					//var R:int = ImageProcessing.getR(RGB);
					//var G:int = ImageProcessing.getG(RGB);
					//var B:int = ImageProcessing.getB(RGB);
					//if (_r_min <= R && R <= _r_max && _g_min <= G && G <= _g_max && _b_min <= B && B <= _b_max)
					if (img.getPixel(i, j))
					//if (false)
					{
						taille++;
						point.x += i;
						point.y += j;
						img.setPixel(i,j,255*256*256);
					}
					/*var RGB:int = img.getPixel(i, j);
					RGB = RGB + 16777216;
					//var R:int = ImageProcessing.getR(RGB);
					//var G:int = ImageProcessing.getG(RGB);
					//var B:int = ImageProcessing.getB(RGB);
					//if (_r_min <= R && R <= _r_max && _g_min <= G && G <= _g_max && _b_min <= B && B <= _b_max)
					if (min <= RGB && RGB <= max)
					{
						taille++;
						point.x += i;
						point.y += j;
						img.setPixel(i,j,255*256*256);
					}*/
					j++;
				}
				i++;
			}
			if( (taille == 0) || (taille < 00))
			{
				point.x = -1;
				point.y = -1;
				taille = 0;
			}
			else
			{
				point.x /= taille;
				point.y /= taille;
			}
			
			//drawRectangle(img, x, y, xx, yy, color);
			return point;
		}
		private function searchColorAndBinaries(img:BitmapData, R_min:int, R_max:int, G_min:int, G_max:int, B_min:int, B_max:int, color:int) : void
		{
			var x:int = -1;
			var y:int = -1;
			var xx:int = -1;
			var yy:int = -1;
			var i:int;
			var j:int;
			/* version basique */
			for (i = 0; i < img.width; i++)
			{
				for (j = 0; j < img.height; j++)
				{
					var RGB:int = img.getPixel(i, j);
					RGB = RGB + 16777216;
					var R:int = ImageProcessing.getR(RGB);
					var G:int = ImageProcessing.getG(RGB);
					var B:int = ImageProcessing.getB(RGB);
					if (R_min <= R && R <= R_max && G_min <= G && G <= G_max && B_min <= B && B <= B_max)
					{
						img.setPixel(i,j,255*256*256 + 255*256 + 255);
						if (x == -1)
						{
							x = i;
							y = j;
							xx = i;
							yy = j;
						}
						else
						{
							if (i < x)
								x = i;
							if (i> xx)
								xx = i;
							if (j < y)
								y = j;
							if (j > yy)
								yy = j;
						}
					}
					else
					{
						img.setPixel(i,j,0);
					}
				}
			}
			ImageProcessing.drawRectangle(img, x, y, xx, yy, color);
		}
	}
}