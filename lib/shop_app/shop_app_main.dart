
import 'package:flutter/material.dart';

import 'screens/product_overview_screen.dart';

void main() => runApp(ShopApp());

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      home: ProductOverviewScreen(),
    );
  }
}


