import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/product_grid.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Widgets/badge.dart';
import 'package:shop_app/Screens/cart_screen.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;

  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<Products>(context, listen: false);
    //final cart = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int selVal) {
              setState(() {
                if (selVal == 0)
                  _showFav = true;
                else
                  _showFav = false;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favourite'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: 1,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showFav),
    );
  }
}
