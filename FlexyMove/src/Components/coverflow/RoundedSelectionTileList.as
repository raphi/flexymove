package Components.coverflow
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import mx.controls.TileList;
	import mx.controls.listClasses.IListItemRenderer;

	public class RoundedSelectionTileList extends TileList
	{
		public function RoundedSelectionTileList()
		{
			super();
		}
		
		override protected function drawSelectionIndicator(
			indicator:Sprite, x:Number, y:Number,
			width:Number, height:Number, color:uint,
			itemRenderer:IListItemRenderer):void
		{
			var g:Graphics = indicator.graphics;
			g.clear();     
			g.beginFill(0x3f4c6b);
			g.lineStyle(2,0x6e7c9d);
			g.drawRoundRect(x,y,itemRenderer.width,height,15,15);
			g.endFill();
		}
		
		override protected function drawHighlightIndicator(indicator:Sprite, x:Number, y:Number,
														   width:Number, height:Number, color:uint,
														   itemRenderer:IListItemRenderer):void
		{
			var g:Graphics = indicator.graphics;
			g.clear();
			g.beginFill(0x3f4c6b,0.5);
			g.lineStyle(2,0x6e7c9d,0.5);
			g.drawRoundRect(x,y,itemRenderer.width,height,15,15);
			g.endFill();
		} 
	}
}