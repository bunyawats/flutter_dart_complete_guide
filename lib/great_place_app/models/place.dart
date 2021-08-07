import 'dart:io';

import 'place_location.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation? locations;
  final File image;

  Place({
    required this.id,
    required this.title,
    this.locations,
    required this.image,
  });
}
