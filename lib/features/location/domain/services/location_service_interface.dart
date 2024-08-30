// import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationServiceInterface{

  Future<dynamic> getAddressFromGeocode(dynamic latLng);

  Future<dynamic> searchLocation(String text);

  Future<dynamic> getPlaceDetails(String? placeID);


}