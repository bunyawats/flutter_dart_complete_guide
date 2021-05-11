import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_list_provider.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editProduct = Product();
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final _productData = Provider.of<ProductList>(
          context,
          listen: false,
        );
        _editProduct = _productData.findById(productId);

        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    print(_editProduct.id);
    print(_editProduct.title);
    print(_editProduct.description);
    print('${_editProduct.price}');
    print(_editProduct.imageUrl);

    final _productData = Provider.of<ProductList>(
      context,
      listen: false,
    );

    if (_editProduct.id != null) {
      _productData.updateProduct(
        _editProduct.id,
        _editProduct,
      );
    } else {
      try {
        await _productData.addProduct(_editProduct);
      } on Exception catch (e) {
        print('e2 : $e');

        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'),
              )
            ],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: _editProduct.title,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          onSaved: (value) {
                            _editProduct.title = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a title.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _editProduct.price.toString(),
                          decoration: InputDecoration(
                            labelText: 'Price',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          onSaved: (value) {
                            _editProduct.price = double.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a price.';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number.';
                            }
                            if (double.parse(value) <= 0) {
                              return 'P;ease a number greater than zero.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _editProduct.description,
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          onSaved: (value) {
                            _editProduct.description = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a description';
                            }
                            if (value.length < 10) {
                              return 'Should be at lease 10 characters long. ';
                            }
                            return null;
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 8,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: _imageUrlController.text.isEmpty
                                  ? Text('Enter URL')
                                  : FittedBox(
                                      child: Image.network(
                                          _imageUrlController.text),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Image URL',
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.url,
                                controller: _imageUrlController,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) => _saveForm(),
                                onSaved: (value) {
                                  _editProduct.imageUrl = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    setState(() {});
                                    return 'Please provide a image URL';
                                  }

                                  const urlPattern =
                                      r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                                  final result = new RegExp(urlPattern,
                                          caseSensitive: false)
                                      .firstMatch(value);
                                  if (result == null) {
                                    return 'Please enter valid URL';
                                  }
                                  return null;
                                },
                                focusNode: _imageFocusNode,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
