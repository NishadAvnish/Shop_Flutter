import 'package:flutter/material.dart';
import 'package:shop4/Provider/product_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('MYSHOP'),
        ),
        body: ProductGrid());
  }
}

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<ProductProvider>(context).items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
          //cross axis space bt column , main axis spacing bt rows
          ),
      itemBuilder: (context, i) =>ChangeNotifierProvider(
          builder: (c)=>loadedProducts[i],
          child: ProductItem(
            /*loadedProducts[i].id,
            loadedProducts[i].title,
            loadedProducts[i].image,*/
          )),
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
    );
  }
}
