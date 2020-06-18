import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';

class ProductGrid extends StatelessWidget {
  final _showFav;
  ProductGrid(this._showFav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = _showFav ? productData.favouriteItem : productData.items;
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      padding: EdgeInsets.all(10),
      children: <Widget>[
        for (var i = 0; i < products.length; i++)
          ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(),
          ),
      ],
    );
  }
}
