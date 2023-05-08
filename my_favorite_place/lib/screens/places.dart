import 'package:flutter/material.dart';
import 'package:my_favorite_place/widgets/places_list.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              //Navigator.of(context).pushNamed(add_place.routeName);
            },
          ),
        ],
      ),
      body: PlacesList(
        places: [],
      ),
    );
  }
}
