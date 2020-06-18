import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/product_details.dart';
import 'Screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'Providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
        },
      ),
    );
  }
}
