import 'package:flutter/Material.dart';


class CartItem {
  final String id, title;
  final int quantity;
  final double price;

  CartItem({@required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price});

}


class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String prodId, String title, double price) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,(existingCartitem)
      =>
          CartItem(id: existingCartitem.id,
              title: existingCartitem.title,
              quantity: existingCartitem.quantity + 1,
              price: existingCartitem.price * (existingCartitem.quantity + 1))
      ); }
    else {
      _items.putIfAbsent(
          prodId, () =>
          CartItem(id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1,));
    }
  }

}