import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/cart_provider.dart';
import 'package:shop4/widgets/sliverExpandableAreaWidget.dart';

import 'CartItem.dart';

class myAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myAppBarState();
  }
}

class myAppBarState extends State<myAppBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.amber,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Text("CART"),
        ),
        body: myScaffoldBody(context),
      ),
    );
  }

  myScaffoldBody(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1562101498-473cd362f948?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(top: 2),
      child: Row(
        children: <Widget>[
          SliverExpandableAreaWidget().orderContainer(context),
          //Spacer(flex: 2),
          ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, i) {
              return CartItemWidget(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              );
            },
          ),
        ],
      ),
    );
  }
}
