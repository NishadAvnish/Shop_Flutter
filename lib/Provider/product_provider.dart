
import 'package:flutter/Material.dart';
import 'package:shop4/Model/products_model.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel> _items=[    ProductModel(
      id: 'p1',
      title: 'Red-Shirt',
      description: "A red shirt it is really good",
      price: 90.00,
      image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),

    ProductModel(
        id: 'p1',
        title: 'Red-Shirt',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
    ProductModel(
        id: 'p2',
        title: 'Red-Pant',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
    ProductModel(
        id: 'p3',
        title: 'gggggg',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
    ProductModel(
        id: 'p4',
        title: 'tshirt',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
  ];


  List<ProductModel> get items{
    return [..._items];

  }

  List<ProductModel> get favouriteItems
  {
    return  _items.where((prod)=> prod.isFavorite).toList();
  }

  ProductModel findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }



  void addProduct()
  {
    notifyListeners();
  }
}