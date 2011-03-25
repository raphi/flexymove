package Movelib
{
	import Movelib.colorsDetection.ColorRange;

	public class LandmarkColor
	{
		public var landmarks:Array;
		static private var instance:LandmarkColor = null;

		/** Don't use this function, the Logs class is a singleton */
		public function LandmarkColor(o:Object)
		{
			//here we define which color corresponds to which finger  
			landmarks.push(new Landmark(255, "pouce", new ColorRange(0, 0)));
			landmarks.push(new Landmark(255, "index", new ColorRange(0, 0)));
			landmarks.push(new Landmark(255, "majeur", new ColorRange(0, 0)));
			landmarks.push(new Landmark(255, "index", new ColorRange(0, 0)));
			landmarks.push(new Landmark(255, "annulaire", new ColorRange(0, 0)));
			landmarks.push(new Landmark(255, "auriculaire", new ColorRange(0, 0)));
		}
		
		public static function getInstance() : LandmarkColor
		{
			if (!instance)
				instance = new LandmarkColor(null);
			return instance;
		}
	}
}