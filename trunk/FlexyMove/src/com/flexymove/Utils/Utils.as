package com.flexymove.Utils
{
	import mx.controls.Alert;
	
	public class Utils
	{
		public function Utils()
		{
		}
		
		/**
		 * Return the id from an YouTube video url
		 */
		public static function getIDFromUrl(videoUrl:String):String
		{
			try
			{
				if (videoUrl.search("http://www.dailymotion.com/video/") != -1) // dailymotion
					return videoUrl.replace("http://www.dailymotion.com/video/", "").substr(0,6);
				else
					return videoUrl.split("?v=")[1].split("&")[0];
			}
			catch (e:*)
			{
				Alert.show("Le lien " + videoUrl + " n'est pas une url YouTube correcte.", "Erreur d'url");
			}
			return null;
		}
	}
}