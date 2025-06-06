import 'package:da3em/features/location/domain/repositories/location_repository_interface.dart';
import 'package:da3em/features/location/domain/services/location_service_interface.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService implements LocationServiceInterface{
  LocationRepositoryInterface locationRepoInterface;

  LocationService({required this.locationRepoInterface});

  @override
  Future getAddressFromGeocode(dynamic latLng) async{
    return await locationRepoInterface.getAddressFromGeocode(latLng);
  }

  @override
  Future getPlaceDetails(String? placeID) async{
    return await locationRepoInterface.getPlaceDetails(placeID);
  }

  @override
  Future searchLocation(String text) async{
    return await locationRepoInterface.searchLocation(text);
  }

}