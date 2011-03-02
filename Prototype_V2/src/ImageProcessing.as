package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import mx.charts.chartClasses.StackedSeries;
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.graphics.codec.PNGEncoder;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ImageProcessing
	{
		public function ImageProcessing()
		{
		}
		public static function getR(RGB:int) :int {
			return ((RGB / 256) / 256) % 256;
		}
		public static function getG(RGB:int) : int
		{
			return (RGB / 256) % 256;
		}
		public static function getB(RGB:int) : int {
			return (RGB) % 256;
		}
		public static function drawRectangle(img:BitmapData, x:int, y:int, xx:int, yy:int, color:int) : void
		{
			var i:int = 0;
			var j:int = 0;
			for(i = x; i <= xx; i++)
			{
				img.setPixel(i, y, color);
				img.setPixel(i, yy, color);
			}
			for (j = y; j < yy; j++)
			{
				img.setPixel(x, j, color);
				img.setPixel(xx, j, color);
			}
		}			
		public static function drawLines(img:BitmapData, x:int, y:int, color:int) : void
		{
			var i:int = 0;
			for (i = 0; i < img.width; i++)
				img.setPixel(i, y, color);
			for (i = 0; i < img.height; i++)
				img.setPixel(x, i, color);
		}
		public static function drawLine(img:BitmapData, x:int, y:int, xx:int, yy:int, color:int) : void
		{
			var i:int = 100;
			while (i >= 0)
			{
				img.setPixel(x + i * (xx - x)/100, y + i * (yy - y)/100, color);
				i--;
			}
		}
		
	}
}