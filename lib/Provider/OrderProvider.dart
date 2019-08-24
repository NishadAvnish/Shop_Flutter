import 'package:flutter/foundation.dart';
import 'cart_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<CartItem> innerList = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrder() async {
    String url = "https://flutter-shop-a7eef.firebaseio.com/order.json";
    try {
      final response = await http.get(url);
      print(response.body);
      List<OrderItem> loadeditem = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((k, v) {
        loadeditem.add(
            OrderItem(id: k,
                amount: v['price'],
                products: func(v),
                dateTime: DateTime.parse(v['datetime'])),
        );
      });
      _orders = loadeditem;
    } on Exception catch (e) {

    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const String url = "https://flutter-shop-a7eef.firebaseio.com/order.json";
    try {
      await http.post(url, body: json.encode({
        "price": total,
        "datetime": DateTime.now().toIso8601String(),
        'products': cartProducts.map((cp) =>
        {
          "title": cp.title,
          "quantity": cp.quantity,
          "id": cp.id,
          "price": cp.price,
        }

        ).toList()}

      ));
    } catch (error) {

    }


    notifyListeners();
  }

  List<CartItem> func(v) {
    for (int i = 0; i < v['products'].length; i++) {


       innerList.add(CartItem(id: v['products'][i]['id'],
          title: v['products'][i]['title'],
          quantity: v['products'][i]['quantity'],
          price: v['products'][i]['price']));
    }
    return innerList;
  }

}
