import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemWidget(
      this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      key: Key(id),
      background: Container(
        margin: EdgeInsets.all(10),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return Center(child: AlertDialog(
                title: Text("Are You Sure?"),
                content: Text("Do You Want To Remove The Current Item"),

                actions: <Widget>[
                  FlatButton(onPressed: () {
                    Navigator.of(ctx).pop(false);
                  }, child: Text("No")),
                  FlatButton(onPressed: () {
                    Navigator.of(context).pop(true);
                  }, child: Text("Yes")),

                ],
              ),);
            }
        );
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: FittedBox(
              child: Text(
                '\$$price',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 2),
            child: Column(
              children: <Widget>[
                Text('$title',
                    style: TextStyle(
                      fontSize: 20 * scaleFactor,
                    )),
                SizedBox(
                  height: 5,
                ),
                Text('Total:${(quantity * price)}',
                    style: TextStyle(
                      fontSize: 12 * scaleFactor,
                    )),
              ],
            ),
          ),
          trailing: Text('$quantity X',
              style: TextStyle(
                fontSize: 18 * scaleFactor,
              )),
        ),
      ),
    );
  }
}
