import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/product_provider.dart';
import 'package:shop4/widgets/product_detail_widget.dart';

class ProductDetailScreen extends StatelessWidget{
  static const routeName='/product_detail_screen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute
        .of(context)
        .settings
        .arguments as String;
    final items = Provider.of<ProductProvider>(context).findById(id);

   final providerid=Provider.of<ProductProvider>(context,listen: false).items.firstWhere((prod)=>prod.id==id);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(providerid.title.toUpperCase()),),
      body: ProductDetailWidget(items),
    );
  }

}