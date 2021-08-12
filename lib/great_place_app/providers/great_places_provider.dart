import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dart_complete_guide/great_place_app/models/place_location.dart';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';
import '../models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation placeLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      placeLocation.latitude,
      placeLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: placeLocation.latitude,
      longitude: placeLocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();

    DbHelper.insert(
      DbHelper.places_table,
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': updatedLocation.latitude,
        'loc_lng': updatedLocation.longitude,
        'address': updatedLocation.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData(DbHelper.places_table);
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
