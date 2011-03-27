package Components.player
{
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	import org.osmf.containers.MediaContainer;
	import org.osmf.elements.VideoElement;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.URLResource;
	/**
	 * The simplest OSMF application possible.
	 *
	 * The metadata sets the SWF size to match that of the video.
	 **/
	[SWF( width="640", height="352" )]
	public class HelloWorld extends UIComponent {
		public function HelloWorld() {
			// Create the container class that displays the media.
			var container:MediaContainer = new MediaContainer();
			addChild( container );
			
			// Create the resource to play.
			var resource:URLResource = new URLResource( "http://mediapm.edgesuite.net/strobe/content/test/AFaerysTale_sylviaApostol_640_500_short.flv" );
			
			// Create the MediaElement and add it to our container class.
			var videoElement:VideoElement = new VideoElement( resource );
			container.addMediaElement( videoElement );
			
			// Set the MediaElement on a MediaPlayer.  Because autoPlay
			// defaults to true, playback begins immediately.
			var mediaPlayer:MediaPlayer = new MediaPlayer();
			mediaPlayer.media = videoElement;
		}
	}
}