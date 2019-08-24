import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Screen/UserProductScreen.dart';
import './Screen/ProductsScreen.dart';
import 'Provider/OrderProvider.dart'show OrderProvider;
import 'Provider/cart_provider.dart';
import 'Provider/product_provider.dart';
import 'Screen/EditUserProduct.dart';
import 'Screen/OrderScreen.dart';
import 'Screen/cartscreen.dart';
import 'Screen/product_detail_screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => ProductProvider(),
          ),
          ChangeNotifierProvider.value(value: CartProvider()),
          ChangeNotifierProvider(
            builder: (context)=>OrderProvider(),
          ),
        ],
        child: MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                cursorColor: Colors.amberAccent,
                primaryColor: Colors.purple,
                primaryColorDark: Colors.white,
                fontFamily: 'Teko'),
            home: ProductScreen(), //object of class product
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreenState.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName:(ctx)=>OrderScreen(),
              UserProductScreen.routeName:(ctx)=>UserProductScreen(),
              EditUserProduct.routeName:(ctx)=>EditUserProduct(),
              ProductScreen.routeName:(ctx)=>ProductScreen(),

            }));
  }
}
