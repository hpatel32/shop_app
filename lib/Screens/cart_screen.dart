import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart' show Cart;
import 'cart_item.dart' as ci;
import 'package:shop_app/Providers/order.dart';

class CartScreen extends StatelessWidget {
  static var routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("ORDER NOW"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Provider.of<Order>(context, listen: false).addOrder(
                          cart.item.values.toList(), cart.totalAmount);
                      cart.clearCart();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) => ci.CartItems(
                  cart.item.values.toList()[i].id,
                  cart.item.keys.toList()[i],
                  cart.item.values.toList()[i].title,
                  cart.item.values.toList()[i].price,
                  cart.item.values.toList()[i].quantity),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
