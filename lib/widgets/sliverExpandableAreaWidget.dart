import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/OrderProvider.dart';
import 'package:shop4/Provider/cart_provider.dart';

class SliverExpandableAreaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image:NetworkImage("https://images.unsplash.com/photo-1562101498-473cd362f948?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"),
        fit: BoxFit.cover,
         ),),
        padding:EdgeInsets.only(top: 2),


        child: orderContainer(context),
    );
  }

  orderContainer(BuildContext context) {

     final cartItem = Provider.of<CartProvider>(context);
     final scaleFactor = MediaQuery.of(context).textScaleFactor;
      return Center(
        child: Container(

          margin: EdgeInsets.only(right: 15,left: 15),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Total',
                style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'Dosis',fontSize: 20*scaleFactor),
              ),

              Chip(
                label: Text(
                  '\$${cartItem.totalamout.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),

              FlatButton(
                onPressed: () => {
                  Provider.of<OrderProvider>(context).addOrder(cartItem.items.values.toList(), cartItem.totalamout),
                  Provider.of<CartProvider>(context).items.clear(),
                },
                child: Text('OrderNow',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              )
            ],
          ),
        ),
      );


  }

}
