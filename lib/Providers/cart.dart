import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  int quantity;
  double price;

  CartItem({this.id, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get item {
    return {..._items};
  }

  void addToCard(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                price: value.price,
                quantity: value.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
  }
}
