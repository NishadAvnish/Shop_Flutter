import 'package:flutter/foundation.dart';

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

  void toggleFavourite(){
    // ignore: unnecessary_statements
    isFavorite=!isFavorite;
    notifyListeners();

  }
}
