import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_list_provider.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_line_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product';

  Future<void> _refreshProduct(BuildContext context) async {
    final _productData = Provider.of<ProductList>(
      context,
      listen: false,
    );
    await _productData.fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productList = Provider.of<ProductList>(
    //   context,
    //   listen: true,
    // );

    print('rebuilding...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Product'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: _refreshProduct(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<ProductList>(
                        builder: (context, productList, _) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            final product = productList.items[index];

                            return Column(
                              children: [
                                UserProductLineItem(
                                  productId: product.id!,
                                  title: product.title,
                                  imageUrl: product.imageUrl,
                                ),
                                Divider(),
                              ],
                            );
                          },
                          itemCount: productList.items.length,
                        ),
                      );
                    }),
                  );
          }),
    );
  }
}
