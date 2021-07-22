import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_list_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductLineItem extends StatelessWidget {
  final String productId;
  final String title;
  final String imageUrl;

  const UserProductLineItem({
    Key key,
    this.productId,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: productId,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  final _productData = Provider.of<ProductList>(
                    context,
                    listen: false,
                  );
                  await _productData.removeProduct(productId);
                } on Exception catch (e) {
                  print(e);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('Deleting fail'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
