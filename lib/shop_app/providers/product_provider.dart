import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;

  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price = 0,
    this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteSataus() {
    isFavorite = !isFavorite;
    print(isFavorite);
    notifyListeners();
  }
}
