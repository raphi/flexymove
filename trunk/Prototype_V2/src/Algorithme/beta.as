package Algorithme
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.BitmapAsset;

	
	public class beta extends algorithme
	{
		public var tab:BitmapData = null;
		public function beta()
		{
		}
		override public function ProcessImage(img:BitmapData) : Point
		{
			return new Point(-1, -1);
		}
		override public function prepare() : void
		{
			tab = new BitmapData(w, h, false, 0);
		}
		/*
		private function checkPoint(img:BitmapData, x:int, y:int) : Boolean
		{
		if (x >= 0 && y >= 0 && x < w && y < h)
		{
		if (tab.getPixel(x, y) != 0)
		return false;
		var RGB:int = img.getPixel(x, y);
		RGB = RGB + 16777216;
		var R:int = ImageProcessing.getR(RGB);
		var G:int = ImageProcessing.getG(RGB);
		var B:int = ImageProcessing.getB(RGB);
		return (r_min.value <= R && R <= r_max.value && g_min.value <= G && G <= g_max.value && b_min.value <= B && B <= b_max.value);
		}
		return false;
		}
		
		private function interpolGroup(img:BitmapData, x:int, y:int, n:int) : void
		{
			var varI:int;
			var varJ:int;
			var f:ArrayCollection = new ArrayCollection();
			var r:int = 10; // interpolation a 'r' pixels
			var size:int = 0;
			var p:Point = new Point();
			var arround:Point;
			var center:Point = new Point();
			var color:int = 0;
			
			switch (n)
			{
				case 0 : color = 0; break;
				case 1 : color = 255; break;
				case 2 : color = 255*256; break;
				case 3 : color = 255*256*256; break;
				case 4 : color = 255 + 255*256; break;
				case 5 : color = 255 + 255*256*256; break;
			}
			color = 255*256;
			var topleft:Point = new Point(x, y);
			var bottomright:Point = new Point(x, y);
			p.x = x;
			p.y = y;
			f.addItem(p);
			while (f.length > 0)
			{
				p = f.getItemAt(0) as Point;
				f.removeItemAt(0);
				tab.setPixel(p.x, p.y, n);
				img.setPixel(p.x, p.y, color);
				size++;
				center.x += p.x;
				center.y += p.y;
				if (topleft.x > p.x)
					topleft.x = p.x;
				if (topleft.y > p.y)
					topleft.y = p.y;
				if (bottomright.x < p.x)
					bottomright.x = p.x;
				if (bottomright.y < p.y)
					bottomright.y = p.y;
				
				for (varI = -r; varI < r; varI++)
				{
					for (varJ = -r; varJ < r; varJ++)
					{
						if (varI == 0 && varJ == 0)
							continue;
						if (checkPoint(img, p.x + varI, p.y + varJ))
						{
							arround = new Point(p.x + varI, p.y + varJ);
							f.addItem(arround);
						}
						tab.setPixel(p.x + varI, p.y + varJ, 2000);
					}
				}
			}
			//le groupe numero 'n' contient 'taille' pixels.
			//if (size > taille)// si on a trouver plus grand
			//{
				//taille = size;
				//point.x = center.x / size;
				//point.y = center.y / size;
			//	point.x = (topleft.x + bottomright.x) / 2
			//	point.y = (topleft.y + bottomright.y) / 2
			//}
		}
		private function findGroups (img:BitmapData) : void
		{
			var i:int;
			var j:int;
			var n:int = 1;
			var r:Rectangle = new Rectangle(0, 0, w, h);
			tab.fillRect(r, 0);
			for (i = 0; i < w; i++)
			{
				for (j = 0; j < h; j++)
				{
					if (checkPoint(img, i, j))
					{
						interpolGroup(img, i, j , n);
						n++;
					}
				}
			}
		}
		//*/
	}
}