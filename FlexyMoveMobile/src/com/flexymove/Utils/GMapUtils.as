package com.flexymove.Utils
{
	import com.google.maps.LatLng;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	import com.google.maps.services.GeocodingResponse;
	import com.google.maps.services.Placemark;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	

	public class GMapUtils extends EventDispatcher
	{
		public function GMapUtils()
		{
		}
		
		/**
		 * Google webservice API : return a string containing the address from a latitude and longitude data
		 */
		public function getAddressFromLatLng(latLng:LatLng):void
		{
			var geocoder:ClientGeocoder = new ClientGeocoder();
			
			// Is it a memory leak?
			geocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, geocodingSuccess);
			geocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, geocodingFailure);
			
			// Run the research
			geocoder.reverseGeocode(latLng);
		}
		
		private function geocodingSuccess(evt:GeocodingEvent):void 
		{
			var result:Placemark = GeocodingResponse(evt.response).placemarks[0];
			
			dispatchEvent(new GMapUtilsEvent(GMapUtilsEvent.GET_ADDRESS, result.address));
		}
		
		private function geocodingFailure(evt:GeocodingEvent):void 
		{
	//		Alert.show("Impossible de définir l'adresse exacte.", "Erreur de géolocalisation");
			trace(evt);
		}
		
	}
}