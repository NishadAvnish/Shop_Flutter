import 'package:flutter/Material.dart';

class CartItem {
  final String id, title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalamout {
    double price = 0.0;
    _items.forEach((key, cartItem) {
      price += cartItem.price * cartItem.quantity;
    });

    return price;
  }

  int get itemCount {
    var quantity = 0;
    if (_items.length > 0) {
      _items.forEach((k, v) => {
            quantity += v.quantity,
          });
    }

    return quantity;
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void addItem(String prodId, String title, double price) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingCartitem) => CartItem(
                id: existingCartitem.id,
                title: existingCartitem.title,
                quantity: existingCartitem.quantity + 1,
                price: existingCartitem.price,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }


    notifyListeners();
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    else if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingKey) => CartItem(
            id: existingKey.id,
            title: existingKey.title,
            quantity: existingKey.quantity-1,
            price: existingKey.price),
      );}

    else {
      _items.remove(productId);}

    notifyListeners();
  }
}
