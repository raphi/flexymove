package Components.coverflow
{
	public class ItemCoverFlow
	{
		public var isFolder:Boolean = false;
		public var title:String = "None";
		public var time:Number = 0;
		public var owner:String = "mine";
		public var chanel:String = "cactus";
		public var idYoutubeVideo : String = "";//"8RHAEwQAZlA";
		[Bindable]
		public var pathImg:String = "";

		public function ItemCoverFlow(folder:Boolean, idyoutube : String = null)
		{
			isFolder = folder;
				
			idYoutubeVideo = idyoutube;
			pathImg = "http://img.youtube.com/vi/"+idYoutubeVideo+"/0.jpg";
		}

	}
}