import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemWidget(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {

    final scaleFactor=MediaQuery.of(context).textScaleFactor;
    // TODO: implement build
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed:(direction){Provider.of<CartProvider>(context, listen: false).removeItem(productId);},
      key: Key(id),
      background: Container(
        color: Theme.of(context).errorColor,
          child:Icon(

          Icons.delete,

          size:12,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),

      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          leading:  CircleAvatar(
            backgroundColor: Colors.purple,
            child: FittedBox(
              child:Text('\$$price',style: TextStyle(color: Colors.white),),
            ),
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 8,bottom: 8,left: 8),
            child: Column(
              children: <Widget>[
                Text('$title',style: TextStyle(fontSize:20*scaleFactor ,)),
                SizedBox(height: 5,),
                Text('Total:${(quantity*price)}',style: TextStyle(fontSize:12*scaleFactor ,)),

              ],
            ),
          ),

          trailing: Text('$quantity X',style: TextStyle(fontSize:22*scaleFactor ,)),

        ),
      ),
    );
  }
}
