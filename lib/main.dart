import 'package:flutter/material.dart';
import './Screen/ProductsScreen.dart';
main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ProductScreen()   //object of class product screen

    );
  }

}