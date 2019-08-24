import 'package:flutter/Material.dart';
import 'package:shop4/Model/httpExceptionModel.dart';
import 'package:shop4/Provider/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _items = [];

  List<ProductModel> get items {
    return [..._items];
  }

  List<ProductModel> get favouriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  ProductModel findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> removeItem(var id) async {
    final String url='https://flutter-shop-a7eef.firebaseio.com/products/$id.json';

    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    var  extractedvalue=_items[prodIndex];


      final response=await http.delete(url);
      if(response.statusCode >=400 && response.statusCode<=600){
        HttpExceptionModel("Something went wrong");
      }

      else{
       _items.removeAt(prodIndex);
       extractedvalue=null;

         }
      notifyListeners();
  }

  Future<void> fetchShow() async {
    const String url =
        'https://flutter-shop-a7eef.firebaseio.com/products.json';
    List<ProductModel> list=[];
    final response = await http.get(url);
    /*print(response.body);*/
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((prodId,value){

      list.add(ProductModel(id:prodId,
      title: value['title'],
      price: value["price"],
      description: value['description'],
      isFavorite: value['isfavourite'],
      image: value["image"],
      ));
    });
    _items=list;
    notifyListeners();
  }


  Future<void> addProduct(ProductModel product) async {
    const String url =
        'https://flutter-shop-a7eef.firebaseio.com/products.json';
    try {
      await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'image': product.image,
            'isfavourite':false,
          }));

     /* final newproduct = ProductModel(
        id: DateTime.now().toString(),
        title: product.title,
        price: product.price,
        description: product.description,
        image: product.image,
      );

      _items.add(newproduct);*/

      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updateProduct(ProductModel products, String id) async {
    final String url="https://flutter-shop-a7eef.firebaseio.com/products/$id.json";
    try {
      await http.patch(url,body: json.encode(
        {
          'title':products.title,
          'description':products.description,
          'price':products.price,
          'image':products.image,
        }
      ));
    } catch(error) {
      throw(error);
    }
   /* final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = products;
    } else {
      print("...");
    }*/
    notifyListeners();
  }
}
