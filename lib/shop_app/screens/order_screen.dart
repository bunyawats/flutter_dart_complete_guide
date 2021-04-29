import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../widgets/order_line_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
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
