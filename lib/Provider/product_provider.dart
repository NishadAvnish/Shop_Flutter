
import 'package:flutter/Material.dart';
import 'package:shop4/Provider/products_model.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel> _items=[    ProductModel(
      id: 'p1',
      title: 'T-Shirt',
      description: "A gray T- shirt it is really good",
      price: 90.00,
      image: "https://images.unsplash.com/photo-1523381294911-8d3cead13475?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),

    ProductModel(
        id: 'p2',
        title: 'Red-Pant',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://www.camillaandmarc.com/media/catalog/product/cache/1/thumbnail/1200x1800/9df78eab33525d08d6e5fb8d27136e95/s/1/s19-18292-c_m-136.1530059252.jpg"),
    ProductModel(
        id: 'p3',
        title: 'BabyShirt',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://images.unsplash.com/photo-1525107372716-1a85946c5dff?ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
    ProductModel(
    id: 'p4',
    title: 'check-Shirt',
    description: "A shirt it is really good",
    price: 90.00,
    image: "https://images.unsplash.com/photo-1542061651-ede3615bcd04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=282&q=80")
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

 void removeItem(var id){
   final prodIndex=_items.indexWhere((prod)=>prod.id==id);
   _items.removeAt(prodIndex);
   notifyListeners();
  }

 void addProduct(ProductModel product){
    final newproduct=ProductModel(
      id:DateTime.now().toString(),
      title:product.title,
      price: product.price,
      description: product.description,
      image: product.image,
    );
    _items.add(newproduct);
    notifyListeners();
 }

 void updateProduct(ProductModel products,String id){
    final prodIndex=_items.indexWhere((prod)=>prod.id==id);
    if(prodIndex>=0){
      _items[prodIndex]=products;
    }
    else{
      print("...");
    }
    notifyListeners();
 }
}