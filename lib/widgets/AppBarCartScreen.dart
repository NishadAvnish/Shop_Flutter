import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/OrderProvider.dart';
import 'package:shop4/Provider/cart_provider.dart';

import 'CartItem.dart';

class MyAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return MyAppBarState();
  }
}

class MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.amber,
              ),
              onPressed: () {
               Navigator.pop(context,false);
               print("print clicked Avnish");
              }),
          title: Text("CART"),
        ),
        resizeToAvoidBottomPadding: false,
        body: myScaffoldBody(context),

    );
  }

  myScaffoldBody(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      height: MediaQuery.of(context).size.height-(MediaQuery.of(context).padding.top)-AppBar().preferredSize.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1562101498-473cd362f948?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"),
          fit: BoxFit.cover,
        ),
      ),
      child:Align(
        alignment: Alignment.topCenter,

      child: Column(

        children: <Widget>[
          Card(
          margin: EdgeInsets.all(15),
          color: Colors.white,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'Dosis',fontSize: 20*scaleFactor),
                  ),

                  Chip(
                    label: Text(
                      '\$${cart.totalamout.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),

                  FlatButton(
                    onPressed: () => {
                      if(cart.items.length>0){
                      Provider.of<OrderProvider>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalamout),
                      Provider.of<CartProvider>(context).clear(),}
                    },
                    child: Text('OrderNow',
                        style: TextStyle(color: Theme.of(context).primaryColor)),
                  )
                ],


              ),
          ),
       SizedBox(height: 8,),
       Expanded(child:ListView.builder(
           itemCount: cart.items.length,
           itemBuilder:(context,index){
             final item=cart.items.values.toList()[index];
             return CartItemWidget(item.id,cart.items.keys.toList()[index],item.price,item.quantity,item.title);
           }),)

         ],
       )


      ),
      );
          

  }

}
