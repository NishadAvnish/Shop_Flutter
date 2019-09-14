import 'package:flutter/material.dart';
import '../Provider/OrderProvider.dart' as odt;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget{
  final odt.OrderItem order;

  OrderItem(this.order);

  @override
  State<StatefulWidget> createState() {

    return OrderItemState();
  }

}
class OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final order=widget.order;
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat("dd//MM/yyyy hh:mm").format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        prod.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${prod.quantity}x \$${prod.price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}