import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
    );

    _items.add(newPlace);
    notifyListeners();

    DbHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }
}
