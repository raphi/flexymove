package Algorithme
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.BitmapAsset;
	
	
	public class beta extends algorithme
	{
		public var _max_found:int = -1;
		public var _point_found:Point = new Point(-1, -1);
		public var tab:BitmapData = null;
		public function beta()
		{
		}
		override public function ProcessImage(img:BitmapData) : Point
		{
			findGroups(img);
			taille = _max_found;
			return _point_found;
		}
		override public function prepare() : void
		{
			tab = new BitmapData(w, h, false, 0);
		}
		
		private function checkPoint(img:BitmapData, x:int, y:int) : Boolean
		{
			if (x >= 0 && y >= 0 && x < w && y < h)
			{
				if (tab.getPixel(x, y) != 0)
					return false;
				return img.getPixel(x, y) != 0;
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
				varI = -r;
				while (varI < r)
				{
					varJ = -r;
					while (varJ < r)
					{
						if (varI == 0 && varJ == 0)
						{
							varJ++;
							continue;
						}
						if (checkPoint(img, p.x + varI, p.y + varJ))
						{
							arround = new Point(p.x + varI, p.y + varJ);
							f.addItem(arround);
						}
						tab.setPixel(p.x + varI, p.y + varJ, 2000);
						varJ++;
					}
					varI++;
				}
			}
			//le groupe numero 'n' contient 'size' pixels.
			if (size > 10 && size > _max_found)// si on a trouver plus grand
			{
				_max_found = size;
				_point_found.x = (topleft.x + bottomright.x) / 2;
				_point_found.y = (topleft.y + bottomright.y) / 2;
				_point_found.x = center.x / size;
				_point_found.y = center.y / size;
			}
		}
		
		private function findGroups (img:BitmapData) : void
		{
			var i:int;
			var j:int;
			var n:int = 1;
			_max_found = -1;
			_point_found.x = -1;
			_point_found.y = -1;
			var rect:Rectangle = new Rectangle(0, 0, _w, _h);
			var p:Point = new Point(0, 0);
			tab.fillRect(rect, 0);
			img.threshold(img, rect, p, '>=', _r_max * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '>=', _g_max * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '>=', _b_max, 0x000000, 0x0000ff);
			
			img.threshold(img, rect, p, '<=', _r_min * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '<=', _g_min * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '<=', _b_min, 0x000000, 0x0000ff);
			i=0;
			while (i < _w)
			{
				j=0;
				while (j < _h)
				{
					if (checkPoint(img, i, j))
					{
						tab.setPixel(i, j, n);
						interpolGroup(img, i, j , n);
						n++;
					}
					j++;
				}
				i++;
			}
		}
	}
}