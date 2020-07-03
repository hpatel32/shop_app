import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
class CartScreen extends StatelessWidget {
  static var routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart"),),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text("Total",style: TextStyle(fontSize: 20),),
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
                    onPressed: (){

                    },
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: null,
                      itemCount: cart.itemCount,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}