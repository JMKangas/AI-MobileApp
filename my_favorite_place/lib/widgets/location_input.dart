// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGettingLocation = false;
  late double longitude;
  late double latitude;

  void _selectTempLocation() async {
    Location location = Location();
    LocationData locationData;
    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    setState(() {
      _isGettingLocation = true;
    });

    longitude = locationData.longitude!;
    latitude = locationData.latitude!;

    setState(() {
      _isGettingLocation = false;
    });
  }

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

    //latitude = locationData.latitude!;
    //longitude = locationData.longitude!;
    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location  asdasd Chosen ${longitude}',
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
        'Lat: 232323 , Lng: ${longitude}',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      );
    } else if (longitude != null) {
      previewContent = Text(
        'Lat: ${latitude}, Lng: ${longitude}',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      );
      /* previewContent = const Text(
        'Lat: 0.0, Lng: 0.0',
        style: TextStyle(
          color: Colors.black54,
        ),
      ); */
    } else {
      /*    previewContent = Text(
        'No Locationasdasd Chosen',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        textAlign: TextAlign.center,
      ); */
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
