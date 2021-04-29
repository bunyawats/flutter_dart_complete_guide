import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {
      ..._items,
    };
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;

    _items.forEach((key, cartItem) {
      total = cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem({
    String productId,
    double price,
    String title,
  }) {
    print('productId $productId');

    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (currentItem) => CartItem(
          id: currentItem.id,
          title: currentItem.title,
          quantity: currentItem.quantity + 1,
          price: currentItem.price,
        ),
      );
    } else {
      final cartItem = CartItem(
        id: '${DateTime.now()}',
        title: title,
        price: price,
        quantity: 1,
      );
      _items.putIfAbsent(
        productId,
        () => cartItem,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
}
