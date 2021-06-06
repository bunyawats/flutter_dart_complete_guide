import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
      firebaseHostName,
      'orders.json',
    );

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print('response: $extractedData');
    if (extractedData == null) {
      return null;
    }

    final List<OrderItem> loadedOrders = [];
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          productList: (orderData['productList'] as List<dynamic>)
              .map(
                (cItem) => CartItem(
                  id: cItem['id'],
                  title: cItem['title'],
                  quantity: cItem['quantity'],
                  price: cItem['price'],
                ),
              )
              .toList(),
        ),
      );
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    print(' call addOrder ');

    try {
      final url = Uri.https(
        firebaseHostName,
        'orders.json',
      );

      final timestamp = DateTime.now();
      final orderBody = json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'productList': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      });

      final response = await http.post(url, body: orderBody);
      print('response ${json.decode(response.body)}');

      final String newID = json.decode(response.body)['name'];
      final _order = OrderItem(
        id: newID,
        amount: total,
        dateTime: timestamp,
        productList: cartProducts,
      );

      _orders.insert(0, _order);
      notifyListeners();
    } on Exception catch (e) {
      print('error: $e');
      throw e;
    }
  }

  void removeOrder(String orderId) {
    notifyListeners();
  }
}
