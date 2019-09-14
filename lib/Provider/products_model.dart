import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


class ProductModel with ChangeNotifier {
  final String id;
  final String title, description;
  final double price;
  final String image;

  bool isFavorite;

  ProductModel(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      this.isFavorite=false });

  Future<void> toggleFavourite(String token,String userId) async{
    // ignore: unnecessary_statements
    final String url='https://flutter-shop-a7eef.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    final oldStatus=isFavorite;
    isFavorite=!isFavorite;
    try {
      if(isFavorite){
      await http.put(url,body:json.encode(
        isFavorite
        ));}
      else{
        try {
          await http.delete(url);
        }  catch (e) {
          isFavorite=oldStatus;
        }
      }
    } catch (error) {
      isFavorite=oldStatus;
    }




    notifyListeners();

  }
}
