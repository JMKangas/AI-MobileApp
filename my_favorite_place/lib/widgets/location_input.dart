// ignore_for_file: unused_local_variable, unused_import, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:my_favorite_place/models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.onSelectLocation})
      : super(key: key);

  final void Function(PlaceLocation selectedLocation) onSelectLocation;

  @override
  _LocationInputState createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;

  var _isGettingLocation = false;
  late double longitude = 0.0;
  late double latitude = 0.0;

  void _selectTempLocation() async {
    Location location = Location();
    LocationData locationData;
    locationData = await location.getLocation();

    if (kDebugMode) {
      print(_pickedLocation?.latitude.toString());
      print(_pickedLocation?.longitude.toString());
    }

    setState(() {
      _isGettingLocation = true;
    });

    longitude = locationData.longitude!;
    latitude = locationData.latitude!;

    setState(() {
      _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
    });

    widget.onSelectLocation(_pickedLocation!);
  }

/*
  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final url = Uri.parse(''),
        response = await http.post(
          url,
          body: {
            'latitude': locationData.latitude.toString(),
            'longitude': locationData.longitude.toString(),
          },
        );

    setState(() {
      _isGettingLocation = false;
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Chosen',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      textAlign: TextAlign.center,
    );

    if (_isGettingLocation) {
      previewContent = const Center(
        child: CircularProgressIndicator(),
      );
      previewContent = Text(
        'Lat: $latitude, Lng: $longitude',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      );
    }

    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: previewContent,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: _selectTempLocation,
            icon: const Icon(Icons.location_on),
            label: const Text('Current Location'),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.map),
            label: const Text('Select on Map'),
          ),
        ],
      )
    ]);
  }
}
