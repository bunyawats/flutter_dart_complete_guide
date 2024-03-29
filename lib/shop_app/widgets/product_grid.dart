import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_list_provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFavoritesOnly;

  const ProductsGrid({super.key, showFavoritesOnly})
      : _showFavoritesOnly = showFavoritesOnly;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductList>(context, listen: false);

    final products = (_showFavoritesOnly)
        ? productProvider.favoriteItems
        : productProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
    );
  }
}
