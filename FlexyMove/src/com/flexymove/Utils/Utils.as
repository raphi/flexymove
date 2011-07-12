package com.flexymove.Utils
{
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
			//Manque la gestion des erreur
			return youTubeUrl.split("?v=")[1].split("&")[0];
		}
	}
}