import 'package:location/location.dart';
import 'package:portfolio/location/models/place_location_model.dart';

Future<PlaceLocation?> getCurrentLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.requestPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }


  locationData = await location.getLocation();
  final lat = locationData.latitude;
  final lon = locationData.longitude;

  if (lat == null || lon == null) return null;

  return PlaceLocation(latitude: lat, longitude: lon, address: '');
}
