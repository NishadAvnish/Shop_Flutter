
import 'package:flutter/Material.dart';
import 'package:shop4/Model/products_model.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel> _items=[    ProductModel(
      id: 'p1',
      title: 'Red-SAhirt',
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

    ProductModel(
        id: 'p1',
        title: 'Red-SAhirt',
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

  void addProduct()
  {
    notifyListeners();
  }
}