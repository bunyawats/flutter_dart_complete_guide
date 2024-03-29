import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product_provider.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  ProductList(
    this.authToken,
    this.userId,
    this._items,
  );

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere(
      (product) => product.id == productId,
    );
  }

  static const firebaseHostName =
      'flutter-be-ee25f-default-rtdb.firebaseio.com';

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    try {
      var url = Uri.https(
        firebaseHostName,
        'products.json',
        filterByUser
            ? {
                'auth': authToken,
                'orderBy': '"creatorId"',
                'equalTo': '"$userId"',
              }
            : {
                'auth': authToken,
              },
      );

      final response = await http.get(url);
      dynamic extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      // print('response: $extractedData');
      if (extractedData == null) {
        return;
      }

      url = Uri.https(
        firebaseHostName,
        '/userFavorites/$userId/.json',
        {'auth': authToken},
      );
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProductList = [];

      extractedData.forEach((prodId, prodData) {
        loadedProductList.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
            imageUrl: prodData['imageUrl'],
          ),
        );
      });
      _items = loadedProductList;
      // notifyListeners();
    } catch (e) {
      print('error: $e');
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    print('ProductList.addProduct');

    try {
      final url = Uri.https(
        firebaseHostName,
        'products.json',
        {'auth': authToken},
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          },
        ),
      );
      print('response ${json.decode(response.body)}');
      String newID = json.decode(response.body)['name'];

      final _product = Product(
        id: newID,
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      );
      _items.add(_product);

      notifyListeners();
    } on Exception catch (e) {
      print('error: $e');
      throw e;
    }
  }

  Future<void> updateProduct(String productId, Product product) async {
    final productIndex =
        _items.indexWhere((product) => product.id == productId);

    print('ProductList.updateProduct: $productIndex');

    if (productIndex >= 0) {
      try {
        final url = Uri.https(
          firebaseHostName,
          'products/$productId.json',
          {'auth': authToken},
        );

        await http.patch(
          url,
          body: json.encode(
            {
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
            },
          ),
        );
        _items[productIndex] = product;
        notifyListeners();
      } on Exception catch (e) {
        print('error: $e');
        throw e;
      }
    }
  }

  Future<void> removeProduct(String productId) async {
    print('ProductList.removeProduct: $productId');

    final existingProductIndex =
        _items.indexWhere((prod) => prod.id == productId);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final url = Uri.https(
      firebaseHostName,
      'products/$productId.json',
      {'auth': authToken},
    );
    final response = await http.delete(url);
    print('response.statusCode ${response.statusCode}');
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Cloud not delete product.');
    }
    // existingProduct = null;
  }
}
