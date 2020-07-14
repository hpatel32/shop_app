import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Widgets/user_product_item.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            for (var i = 0; i < productData.items.length; i++)
              UserProductItem(productData.items[i].id,
                  productData.items[i].title, productData.items[i].imageUrl),
          ],
        ),
      ),
    );
  }
}
