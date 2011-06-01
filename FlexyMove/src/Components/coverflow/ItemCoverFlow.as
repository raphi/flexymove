package Components.coverflow
{
	public class ItemCoverFlow
	{
		public var isFolder:Boolean = false;
		public var title:String = "None";
		public var time:Number = 0;
		public var owner:String = "mine";
		public var chanel:String = "cactus";
		[Bindable]
		public var pathImg:String = "";

		public function ItemCoverFlow(folder:Boolean)
		{
			isFolder = folder;
		}
	}
}