import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget{
  static const routeName='/product_detail_screen';
  @override
  Widget build(BuildContext context) {
   final id=ModalRoute.of(context).settings.arguments.toString();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
    );
  }

}