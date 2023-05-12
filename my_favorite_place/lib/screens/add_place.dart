import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_favorite_place/providers/user_places.dart';
import 'package:my_favorite_place/widgets/image_input.dart';
import 'package:my_favorite_place/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    if (_titleController.text.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(UserPlacesNotifierProvider.notifier)
        .addPlace(_titleController.text, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) => {
                _selectedImage = image,
              },
            ),
            const SizedBox(height: 10),
            LocationInput(),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _savePlace,
              child: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
