import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_favorite_place/providers/user_places.dart';
import 'package:my_favorite_place/widgets/places_list.dart';
import 'package:my_favorite_place/screens/add_place.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(UserPlacesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: PlacesList(
          places: userPlaces,
        ),
      ),
    );
  }
}
