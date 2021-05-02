import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_list_provider.dart';
import '../widgets/user_product_line_item.dart';
import '../widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product';

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(
      context,
      listen: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Product'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            final product = productList.items[index];

            return Column(
              children: [
                UserProductLineItem(
                  title: product.title,
                  imageUrl: product.imageUrl,
                ),
                Divider(),
              ],
            );
          },
          itemCount: productList.items.length,
        ),
      ),
    );
  }
}
