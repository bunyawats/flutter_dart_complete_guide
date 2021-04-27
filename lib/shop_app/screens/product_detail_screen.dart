
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {

  final String title;

  const ProductDetailScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
