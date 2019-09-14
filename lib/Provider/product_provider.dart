import 'package:flutter/Material.dart';
import 'package:shop4/Model/httpExceptionModel.dart';
import 'package:shop4/Provider/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _items = [];
  final String authToken;
  final String userId;

  ProductProvider(this.authToken, this.userId,
      this._items); //cnstructor for having new token from auth provider

  List<ProductModel> get items {
    return [..._items];
  }

  List<ProductModel> get favouriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  ProductModel findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }



  Future<void> fetchShow([bool filterByUser = false]) async {
    final filterString=filterByUser?'orderBy="creator"&equalTo="$userId"':'';
    var url =
        "https://flutter-shop-a7eef.firebaseio.com/products.json?auth=$authToken&$filterString";
    List<ProductModel> list = [];
    final response = await http.get(url);
    /*print(response.body);*/
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    url= 'https://flutter-shop-a7eef.firebaseio.com/userFavourites/$userId.json?auth=$authToken';
    final favouriteResponse = await http.get(url);
    final favouriteData =json.decode(favouriteResponse.body);


    extractedData.forEach((prodId, value) {
      list.add(ProductModel(
        id: prodId,
        title: value['title'],
        price: value["price"],
        description: value['description'],
        isFavorite:favouriteData==null?false:favouriteData[prodId]??false,
        image: value["image"],
      ));
    });
    _items = list;
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    final String url =
        'https://flutter-shop-a7eef.firebaseio.com/products.json?auth=$authToken';
    try {
      await http.post(url,
          body: json.encode({
            'creator':userId,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'image': product.image,
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
    final String url =
        "https://flutter-shop-a7eef.firebaseio.com/products/$id.json?auth=$authToken";
    try {
      await http.patch(url,
          body: json.encode({
            'title': products.title,
            'description': products.description,
            'price': products.price,
            'image': products.image,
          }));
    } catch (error) {
      throw (error);
    }
    /* final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = products;
    } else {
      print("...");
    }*/
    notifyListeners();
  }

  Future<void> removeItem(var id) async {
    final String url =
        'https://flutter-shop-a7eef.firebaseio.com/products/$id.json?auth=$authToken';

    final String deleteUrl="https://flutter-shop-a7eef.firebaseio.com/userFavourites.json?auth=$userId&orderBy=$id&equalTo=true";
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    var extractedvalue = _items[prodIndex];

    final deleteResponse=await http.delete(deleteUrl);
    final response = await http.delete(url);

    if (response.statusCode >= 400 && response.statusCode <= 600) {
      HttpExceptionModel("Something went wrong");
    }
    else
             if(deleteResponse.statusCode >= 400 && deleteResponse.statusCode <= 600)
               {
                 throw http.ClientException("Something went wrong");
               }
              _items.removeAt(prodIndex);
              extractedvalue = null;}

    notifyListeners();

  }

