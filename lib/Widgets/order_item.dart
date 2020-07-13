import 'package:flutter/material.dart';
import 'package:shop_app/Providers/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orders;

  OrderItemWidget(this.orders);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orders.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.orders.datetime)),
            trailing: IconButton(
                icon: (_expanded)
                    ? Icon(Icons.expand_less)
                    : Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
              height: min(widget.orders.products.length * 20.0 + 100, 180),
              child: ListView(
                children: <Widget>[
                  for (var i = 0; i < widget.orders.products.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.orders.products[i].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${widget.orders.products[i].quantity} x \$${widget.orders.products[i].price}",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        )
                      ],
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
