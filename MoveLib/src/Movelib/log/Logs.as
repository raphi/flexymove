package Movelib.log
{
	import flash.net.FileReference;

	public class Logs
	{
		private var file:FileReference;
		static private var instance:Logs = null;
		
		/** Don't use this function, the Logs class is a singleton */
		public function Logs(o:Object)
		{
			file = new FileReference();
		}
		
		public static function getInstance() : Logs
		{
			if (!instance)
				instance = new Logs(null);
			return instance;
		}

		/** Save the data into the file */
		public function save(message:String, type:String = "", functionName:String = "", packageName:String = "") : void
		{
			
		}
	}
}