package Movelib.imageAcquisition
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.Timer;
	
	public class ImageAcquisition
	{
		private var camera:Camera = null;
		public var snapshot:BitmapData = new BitmapData(400, 300, false, 0xFFFFFF);
		public var video:Video = null;
		
		public function ImageAcquisition()
		{
			camera = Camera.getCamera();
			if (camera)
			{
 				camera.setMode(400, 300, 20, true);
				video = new Video(400, 300);
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
			//Matrix to swap the video
			//new Matrix(-1, 0, 0, 1, 400, 0)
			snapshot.draw(video, new Matrix(-1, 0, 0, 1, 400, 0));
			return snapshot; 
		}
	}
}