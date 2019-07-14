import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Screen/ProductsScreen.dart';
import 'Provider/product_provider.dart';
import 'Screen/product_detail_screen.dart';


main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      builder: (context)=>ProductProvider(),
      child:MaterialApp(
      title: 'MyShop',
      theme: ThemeData(primarySwatch: Colors.purple,
                       accentColor: Colors.deepOrange,
                       fontFamily: 'Teko'),
      home: ProductScreen(), //object of class product
      routes: {ProductDetailScreen.routeName:(context)=>ProductDetailScreen()
    }

    ));
  }

}