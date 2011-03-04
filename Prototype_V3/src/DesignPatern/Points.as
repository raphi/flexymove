package DesignPatern
{
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class Points // flyWeight
	{
		private static var _tab:ArrayCollection;
		public static var nul:Point = new Point(-1, -1);
		
		public function Points()
		{
		}
		public static function initializeAllPoint(w:int, h:int) : void
		{
			_tab = new ArrayCollection();
			var i:int = 0;
			var j:int = 0;
			while (i < w)
			{
				_tab.addItem(new ArrayCollection());
				j = 0;
				while (j < h)
				{
					(_tab[i] as ArrayCollection).addItem(new Point(i, j));
					j++;
				}
				i++;
			}
		}
		public static function test(w:int, h:int) : void
		{
			var i:int;
			var j:int;
			i = 0;
			var s:String = "";
			while (i < w)
			{
				j = 0;
				while (j < h)
				{
					if (_tab[i][j].x == i && _tab[i][j].y == j)
						s += " ";
					else
						s += "X";
					j++;
				}
				s += "\n";
				i++;
			}
			Alert.show(s);
		}
		public static function tab(i:int, j:int) : Point
		{
			if (i >= 0 && j >= 0 && i < _tab.length && j < (_tab[i] as ArrayCollection).length)
			{
				return _tab[i][j];
			}
			return nul;
		}
	}
}