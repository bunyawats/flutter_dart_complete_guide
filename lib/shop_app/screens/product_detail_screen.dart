import 'package:flutter/material.dart';
import 'package:flutter_dart_complete_guide/shop_app/providers/product_list_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final productList = Provider.of<ProductList>(
      context,
      listen: false,
    );
    final loadProduct = productList.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadProduct.title),
      ),
    );
  }
}
