import 'package:flutter/material.dart';

import '../screens/order_screen.dart';
import '../screens/product_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            trailing: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                ProductOverviewScreen.routeName,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            trailing: Text('Order'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                OrderScreen.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
