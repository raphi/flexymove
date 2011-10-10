package com.flexymove.Utils
{
	import mx.collections.ArrayCollection;
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
				if (urlIsPicture(videoUrl))
					return "picture";
				
				if (videoUrl.search("http://www.dailymotion.com/video/") != -1) // dailymotion
					return videoUrl.replace("http://www.dailymotion.com/video/", "").substr(0,6);
				else
					// YouTube link
					return videoUrl.split("?v=")[1].split("&")[0];
			}
			catch (e:*)
			{
				Alert.show("Le lien " + videoUrl + " n'est pas une URL correcte.\n" +
					"Les liens YouTube ou Dailymotion sont acceptés ainsi que les PNG, JPG, ou GIF.", "Erreur d'url");
			}
			return null;
		}
		
		public static function urlIsPicture(url:String):Boolean
		{
			var extentionArray : ArrayCollection = new ArrayCollection(["png", "jpg", "gif"]);
			var extention : String = url.substring(url.lastIndexOf(".") + 1, url.length);
		
			for (var i :int = 0 ; i < extentionArray.length ; i++)
			{
				if(extention == extentionArray[i])
					return true;
			}
			
			return false;
		}
	}
}