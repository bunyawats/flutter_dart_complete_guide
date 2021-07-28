import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/order_provider.dart';

class OrderLineItem extends StatefulWidget {
  final OrderItem order;

  const OrderLineItem({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  _OrderLineItemState createState() => _OrderLineItemState();
}

class _OrderLineItemState extends State<OrderLineItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm');

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              dateFormat.format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          //if (_expanded)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            height: _expanded
                ? min(
                    widget.order.productList.length * 20.0 + 10,
                    100,
                  )
                : 0,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final cartItem = widget.order.productList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      cartItem.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${cartItem.quantity}x \$${cartItem.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
              itemCount: widget.order.productList.length,
            ),
          )
        ],
      ),
    );
  }
}
