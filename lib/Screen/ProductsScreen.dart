import 'package:flutter/material.dart';
import '../Model/products_model.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../Provider/products_provider.dart';

class ProductScreen extends StatelessWidget {
  final List<ProductModel> loadedProducts = [
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

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('MYSHOP'),
        ),
        body: new ProductGrid());
  }
}

class ProductGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ProductsProvider>(context);
    final loadedProducts=provider.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 2.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
          //cross axis space bt column , main axis spacing bt rows
          ),
      itemBuilder: (context, i) => ProductItem(loadedProducts[i].id,
          loadedProducts[i].title, loadedProducts[i].image),
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
    );
  }
}
