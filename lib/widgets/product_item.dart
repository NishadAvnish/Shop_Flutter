
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget{
  final String id,title,imageurl;

  ProductItem(this.id, this.title, this.imageurl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridTile(child: Image.network(imageurl),);
  }
  
  
}