import 'package:flutter/material.dart';
import './Screen/ProductsScreen.dart';
import 'Screen/product_detail_screen.dart';
main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(primarySwatch: Colors.purple,
                       accentColor: Colors.deepOrange,
                       fontFamily: 'Teko'),
      home: ProductScreen(), //object of class product
      routes: {ProductDetailScreen.routeName:(context)=>ProductDetailScreen()
    }

    );
  }

}