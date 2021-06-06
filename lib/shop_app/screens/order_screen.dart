import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_line_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      final orderData = Provider.of<OrderList>(
        context,
        listen: false,
      );
      await orderData.fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final order = orderData.orders[index];
                return OrderLineItem(
                  order: order,
                );
              },
              itemCount: orderData.orders.length,
            ),
    );
  }
}
