import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            width: double.infinity,
            height: 300,
          ),
          SizedBox(
            height: 10,
          ),
          Text('\$${product.price}'),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                product.description,
                softWrap: true,
              )),
        ],
      ),
    );
  }
}
