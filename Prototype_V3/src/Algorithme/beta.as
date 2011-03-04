package Algorithme
{
	import DesignPatern.Points;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.BitmapAsset;
	import mx.core.DesignLayer;
	
	
	public class beta extends algorithme
	{
		public var _max_found:int = -1;
		public var _point_found:Point;
		public var tab:BitmapData = null;
		public function beta()
		{
		}

		override public function prepare() : void
		{
			tab = new BitmapData(w, h, false, 0);
			_point_found = DesignPatern.Points.nul;
		}

		override public function ProcessImage(img:BitmapData) : Point
		{
			_point_found = DesignPatern.Points.nul;
			_max_found = -1;
			taille = -1;
			findGroups(img);
			taille = _max_found;
			return _point_found;
		}

		private function checkPoint(img:BitmapData, x:int, y:int) : Boolean
		{
			if (x >= 0 && y >= 0 && x < _w && y < _h)
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
			var r:int = 4; // interpolation a 'r' pixels
			var size:int = 0;
			var p:Point = DesignPatern.Points.nul;
			var arround:Point;
			var color:int = 255;
			var topleft:Point = DesignPatern.Points.tab(x, y);
			var bottomright:Point = DesignPatern.Points.tab(x, y);
			switch (n)
			{
				case 1 : color = 255*256; break;
				case 2 : color = 255*256*256; break;
				case 3 : color = 255 + 255*256; break;
				case 4 : color = 255 + 255*256*256; break;
				case 5 : color = 255 + 255*256 + 255*256*256; break;
			}
			p = DesignPatern.Points.tab(x, y);
			f.addItem(p);
			while (f.length > 0)
			{
				p = f.getItemAt(0) as Point;
				f.removeItemAt(0);
				if (p.x == -1)
					Alert.show("Null value in the queue");
				tab.setPixel(p.x, p.y, n);
				img.setPixel(p.x, p.y, color);
				size++;
				topleft = DesignPatern.Points.tab(Math.min(topleft.x, p.x), Math.min(topleft.y, p.y));
				bottomright = DesignPatern.Points.tab(Math.max(bottomright.x, p.x), Math.max(bottomright.y, p.y));
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
						//Alert.show("put " + p.x + " - " + p.y);
						if (checkPoint(img, p.x + varI, p.y + varJ))
						{
							//Alert.show("put " + arround.x + " - " + arround.y);
							arround = DesignPatern.Points.tab(p.x + varI, p.y + varJ);
							f.addItem(arround);
						}
						tab.setPixel(p.x + varI, p.y + varJ, 2000);
						varJ++;
					}
					varI++;
				}
			}
			//le groupe numero 'n' contient 'size' pixels.
			if (size > 15 && size > _max_found)// si on a trouver plus grand
			{
				_max_found = size;
				_point_found = DesignPatern.Points.tab((topleft.x + bottomright.x) / 2,(topleft.y + bottomright.y) / 2);
				if (_point_found.x == -1)
					Alert.show("_point_found == nul");
			}
		}
		
		private function findGroups (img:BitmapData) : void
		{
			var i:int;
			var j:int;
			var n:int = 1;
			var rect:Rectangle = new Rectangle(0, 0, _w, _h);
			tab.fillRect(rect, 0);
			_max_found = -1;
			_point_found = DesignPatern.Points.nul;
			var p:Point = new Point(0, 0);
			img.threshold(img, rect, p, '>=', _r_max * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '>=', _g_max * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '>=', _b_max, 0x000000, 0x0000ff);
			
			img.threshold(img, rect, p, '<=', _r_min * 256 * 256, 0x000000, 0xff0000);
			img.threshold(img, rect, p, '<=', _g_min * 256, 0x000000, 0x00ff00);
			img.threshold(img, rect, p, '<=', _b_min, 0x000000, 0x0000ff);
			i = 0;
			while (i < _w)
			{
				j = 0;
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
			//Alert.show(n + " groupes")
		}
	}
}