package Movelib.preProcessing
{
	import flash.display.BitmapData;

	public class PreProcessing
	{
		public function PreProcessing()
		{
		}

		//virtual function : modify the BitmapData parameter to simplify futur traitements
		public function apply(img:BitmapData) : void
		{
			for(var i:int = 0; i < 50; i++) 
				for(var j:int = 0; j < 5; j++) 
					img.setPixel(i,j,255);
		}
	}
}