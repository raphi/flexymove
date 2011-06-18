package com.flexymove
{
	import com.google.maps.LatLng;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	import com.google.maps.services.Placemark;

	public class GMapUtils
	{
		public function GMapUtils()
		{
		}
		
		// FIXME doesnt work yet
		/**
		 * Google webservice API : return a string containing the address from a latitude and longitude data
		 */
		public function getAddressFromLatLng(latLng:LatLng):String
		{
			var geocoder:ClientGeocoder;
			var returnedAddress:String = "";
			
			// Is it a memory leak?
			geocoder.addEventListener(
				GeocodingEvent.GEOCODING_SUCCESS,
				function(event:GeocodingEvent):void
				{
				});
			
			// Run the research
			geocoder.reverseGeocode(latLng);
			
			return returnedAddress;
		}
	}
}