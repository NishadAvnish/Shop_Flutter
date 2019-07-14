import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget{
  static const routeName='/product_detail_screen';
  @override
  Widget build(BuildContext context) {
   final id=ModalRoute.of(context).settings.arguments.toString();
   final providerid=Provider.of<ProductProvider>(context,listen: false).items.firstWhere((prod)=>prod.id==id);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(providerid.title.toUpperCase()),),
      
    );
  }

}