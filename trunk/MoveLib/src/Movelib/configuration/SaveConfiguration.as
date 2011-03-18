package Movelib.configuration
{
	import flash.net.FileReference;

	public class SaveConfiguration
	{
		private var file:FileReference;

		/** Don't use this function, the Logs class is a singleton */
		public function SaveConfiguration()
		{
			file = new FileReference();
		}

		/** Save the data into the file */
		public function save(key:String, value:String) : void
		{
			
		}
	}
}