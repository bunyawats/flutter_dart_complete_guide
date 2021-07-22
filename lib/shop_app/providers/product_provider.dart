import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  static const firebaseHostName =
      'flutter-be-ee25f-default-rtdb.firebaseio.com';

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    print('Call Product.toggleFavoriteStatus: ${!isFavorite}');

    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.https(
      firebaseHostName,
      '/userFavorites/$userId/$id.json',
      {'auth': authToken},
    );

    try {
      final response = await http.get(url);
      final _body = json.decode(response.body);
      print('response $_body');

      // if (_body == null) {
      //   throw HttpException('Cloud not find product.');
      // } else {
      //   await http.patch(
      //     url,
      //     body: json.encode(
      //       {
      //         'isFavorite': isFavorite,
      //       },
      //     ),
      //   );
      // }

      await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
    } on Exception catch (e) {
      print('handle: $e');
      isFavorite = !isFavorite;
      notifyListeners();
      throw e;
    }
  }
}
