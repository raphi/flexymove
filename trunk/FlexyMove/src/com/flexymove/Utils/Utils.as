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
		public static function getIDFromUrl(youTubeUrl:String):String
		{
			try
			{
				return youTubeUrl.split("?v=")[1].split("&")[0];
			}
			catch (e:*)
			{
				Alert.show("Le lien " + youTubeUrl + " n'est pas une url YouTube correcte.", "Erreur d'url");
			}
			return null;
		}
	}
}