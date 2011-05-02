package Components.player.youtube.components
{
	import flash.system.Security;

	public class FlexYouTube extends YouTubeAS3
	{
		public function FlexYouTube()
		{
			super();
			Security.allowInsecureDomain("*");
			Security.allowDomain("*");
		}
		
	}
}