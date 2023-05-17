import 'package:flutter/material.dart';

import 'package:my_favorite_place/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    //final placeId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Hero(
              tag: place.id,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 55,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30,
                    ),
                    child: Text(
                      place.location!.latitude.toStringAsFixed(2) +
                          ', ' +
                          place.location!.longitude.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
