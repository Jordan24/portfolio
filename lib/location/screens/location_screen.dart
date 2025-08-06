import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:portfolio/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:portfolio/location/models/place_location_model.dart';
import 'package:portfolio/location/screens/map_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  PlaceLocation? _pickedLocation;
  var _isLoading = false;

  String get locationImage {
    if (_pickedLocation == null) return '';
    final lat = _pickedLocation!.latitude;
    final lon = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7C%7C$lat,$lon&key=${Env.googleMapsApiKey}';
  }

  Future<void> _savePlace(double lat, double lon) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=${Env.googleMapsApiKey}',
    );
    final response = await http.get(url);
    final responseData = jsonDecode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lon,
        address: address,
      );
      _isLoading = false;
    });
  }

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

    setState(() {
      _isLoading = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;

    if (lat == null || lon == null) {
      setState(() {
        _isLoading = false;
      });
      return null;
    }

    _savePlace(lat, lon);

    return PlaceLocation(latitude: lat, longitude: lon, address: '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget locationContent = Center(
      child: Text(
        'No location selected',
        style: theme.textTheme.bodyLarge!.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (_pickedLocation != null) {
      locationContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('Could not load location image'));
        },
      );
    }

    if (_isLoading) {
      locationContent = const Center(child: CircularProgressIndicator());
    }

    void selectOnMap() async {
      final PlaceLocation? currentLocation =
          _pickedLocation ?? await getCurrentLocation();
      final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
          builder:
              (ctx) => MapScreen(
                location: PlaceLocation(
                  latitude: currentLocation?.latitude ?? 37.422,
                  longitude: currentLocation?.longitude ?? -122.084,
                  address: "",
                ),
              ),
        ),
      );

      if (selectedLocation == null) return;

      _savePlace(selectedLocation.latitude, selectedLocation.longitude);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Location')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Center(
              child: Container(
                height: 240,
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 500),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: locationContent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.location_on),
                  label: const Text('Get Current Location'),
                  onPressed: getCurrentLocation,
                ),
                SizedBox(width: 24),
                TextButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Select on Map'),
                  onPressed: selectOnMap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
