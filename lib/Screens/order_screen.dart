import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/order.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '\orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          for (var i = 0; i < orderData.getOrder.length; i++)
            OrderItemWidget(orderData.getOrder[i]),
        ],
      ),
    );
  }
}
