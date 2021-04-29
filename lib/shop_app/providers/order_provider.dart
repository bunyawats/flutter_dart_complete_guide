import 'package:flutter/foundation.dart';
import 'package:flutter_dart_complete_guide/shop_app/providers/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> productList;
  final DateTime dateTime;

  OrderItem({
    this.id,
    this.amount,
    this.productList,
    this.dateTime,
  });
}

class OrderList with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: '${DateTime.now()}',
          amount: total,
          dateTime: DateTime.now(),
          productList: cartProducts,
        ));
    notifyListeners();
    print(' call addOrder ');
  }

  void removeOrder(String orderId) {
    notifyListeners();
  }
}
