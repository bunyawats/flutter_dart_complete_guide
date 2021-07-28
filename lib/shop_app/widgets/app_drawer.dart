import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/order_screen.dart';
// import '../helpers/custom_route.dart';
import '../screens/product_overview_screen.dart';
import '../screens/user_product_screen.dart';
import '../providers/auth.dart';

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
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => OrderScreen(),
              //   ),
              // );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            trailing: Text('Manage Product'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                UserProductScreen.routeName,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            trailing: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              final auth = Provider.of<Auth>(context, listen: false);
              auth.logout();
            },
          ),
        ],
      ),
    );
  }
}
