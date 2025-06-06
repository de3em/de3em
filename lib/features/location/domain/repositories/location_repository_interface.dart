import 'package:da3em/interface/repo_interface.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getAddressFromGeocode(dynamic latLng);

  Future<dynamic> searchLocation(String text);

  Future<dynamic> getPlaceDetails(String? placeID);
}