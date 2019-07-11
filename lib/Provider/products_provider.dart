
import 'package:flutter/material.dart';
import 'package:shop4/Model/products_model.dart';

class ProductsProvider with ChangeNotifier{

  List<ProductModel> _items=[];

  List<ProductModel> get items{
    return [..._items];

    // ... provide a copy of items so that no one can access the original from outside this
  }

   void addProduct(){
    //_items.add(value);
    notifyListeners();
   }
}