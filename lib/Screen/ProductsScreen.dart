import 'package:flutter/material.dart';
import '../Model/products_model.dart';
import '../widgets/product_item.dart';

class ProductScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
    Product(
        id: 'p1',
        title: 'Red-SAhirt',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
    Product(
        id: 'p2',
        title: 'Red-Pant',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
    Product(
        id: 'p3',
        title: 'gggggg',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
    Product(
        id: 'p4',
        title: 'tshirt',
        description: "A red shirt it is really good",
        price: 90.00,
        image: "https://i.ytimg.com/vi/sJIU1F0qk_I/maxresdefault.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('MYSHOP'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10
              //cross axis space bt column , main axis spacing bt rows
              ),
          itemBuilder: (context, i) => ProductItem(loadedProducts[i].id,
              loadedProducts[i].title, loadedProducts[i].image),
          padding: const EdgeInsets.all(10.0),
          itemCount: loadedProducts.length,
        ));
  }
}
