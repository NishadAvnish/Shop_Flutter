import 'package:flutter/foundation.dart';

class Product{
   final String id;
   final String title,description;
   final double price;
   final String image;

   bool isFavorite;

   Product({@required this.id, @required this.title,@required  this.description, @required this.price,@required  this.image,
       this.isFavorite=false});
}