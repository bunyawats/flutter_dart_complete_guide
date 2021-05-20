import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'cart_provider.dart';

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

  static const firebaseHostName =
      'flutter-be-ee25f-default-rtdb.firebaseio.com';

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      final url = Uri.https(
        firebaseHostName,
        'orders.json',
      );
      final timestamp = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'productList': cartProducts
                .map((cp) => {
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          },
        ),
      );
      print('response ${json.decode(response.body)}');
      String newID = json.decode(response.body)['name'];

      final _order = OrderItem(
        id: newID,
        amount: total,
        dateTime: timestamp,
        productList: cartProducts,
      );

      _orders.insert(0, _order);
      notifyListeners();

      print(' call addOrder ');
    } on Exception catch (e) {
      print('error: $e');
      throw e;
    }
  }

  void removeOrder(String orderId) {
    notifyListeners();
  }
}
