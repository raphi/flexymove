package Movelib.imageAcquisition
{
	import flash.display.BitmapData;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.Timer;
	
	public class ImageAcquisition
	{
		private var camera:Camera = null;
		public var snapshot:BitmapData = new BitmapData(400, 300, false, 0);
		public var video:Video = null;
		
		public function ImageAcquisition()
		{
			camera = Camera.getCamera();
			if (camera)
			{
				camera.setMode(400, 300, 25, true);
				video = new Video(400,300);
				video.attachCamera(camera);
			}
		}

		//initialise the camera with the correct parameter
		public function initCamera() : void
		{
			
		}

		//get an image from the camera
		public function capturePicture() : BitmapData
		{
			snapshot.draw(video);
			return snapshot; 
		}
	}
}