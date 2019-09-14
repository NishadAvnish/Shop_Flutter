import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Screen/UserProductScreen.dart';
import 'package:shop4/Screen/auth-screen.dart';
import './Screen/ProductsScreen.dart';
import 'Provider/OrderProvider.dart'show OrderProvider;
import 'Provider/cart_provider.dart';
import 'Provider/product_provider.dart';
import 'Screen/EditUserProduct.dart';
import 'Screen/OrderScreen.dart';
import 'Screen/cartscreen.dart';
import 'Screen/product_detail_screen.dart';
import './Provider/AuthProvider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),

          ChangeNotifierProxyProvider<AuthProvider,ProductProvider>(
            builder: (ctx,auth,previousState) => ProductProvider(auth.token,auth.userId,previousState==null?[]:previousState.items),
          ),
          ChangeNotifierProvider.value(value: CartProvider()),
          ChangeNotifierProxyProvider<AuthProvider,OrderProvider>(
            builder: (ctx,auth,previousState)
                {
                return OrderProvider(auth.token,previousState==null?[]:previousState.orders,auth.userId);}
          ),


        ],
        child: Consumer<AuthProvider>(builder: (context,authData,_){
          print("main consumer");
          return MaterialApp(

              debugShowCheckedModeBanner: false,
              title: 'MyShop',
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  canvasColor: Colors.white,
                  accentColor: Colors.deepOrange,
                  cursorColor: Colors.amberAccent,
                  primaryColor: Colors.purple,
                  primaryColorDark: Colors.white,
                  fontFamily: 'Teko'),
              home: authData.isAuth?ProductScreen():FutureBuilder(
                future: authData.autoLogin(),
                builder: (ctx,snapshot)=>snapshot.connectionState==ConnectionState.waiting?Center(child:CircularProgressIndicator()):AuthScreen(),
              ), //object of class product
              routes: {
                ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
                CartScreenState.routeName: (ctx) => CartScreen(),
                AuthScreen.routeName:(ctx)=>AuthScreen(),
                OrderScreen.routeName:(ctx)=>OrderScreen(),
                UserProductScreen.routeName:(ctx)=>UserProductScreen(),
                EditUserProduct.routeName:(ctx)=>EditUserProduct(),
                ProductScreen.routeName:(ctx)=>ProductScreen(),

              });

        },));
  }

}
