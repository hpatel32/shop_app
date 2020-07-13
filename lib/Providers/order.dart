import 'package:flutter/cupertino.dart';
import 'package:shop_app/Providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime datetime;
  final List<CartItem> products;

  OrderItem({this.id, this.amount, this.datetime, this.products});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get getOrder {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        datetime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
