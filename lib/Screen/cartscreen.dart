
import 'package:flutter/material.dart';
import 'package:shop4/widgets/AppBarCartScreen.dart';



class CartScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return CartScreenState();
  }}

  class CartScreenState extends State<CartScreen>{

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {


    return MyAppBar();


  }


}