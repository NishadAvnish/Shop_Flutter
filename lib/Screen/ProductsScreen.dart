import 'package:flutter/material.dart';
import 'package:shop4/Provider/product_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

enum filterOption {
  favourite,
  all,
}

class ProductScreen extends StatefulWidget {
  @override
  ProductOverviewScreenState createState() => ProductOverviewScreenState();
}

class ProductOverviewScreenState extends State<ProductScreen> {
  var _showOnlyFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MYSHOP'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (filterOption selectedValue) {
                setState(() {
                  if (selectedValue == filterOption.favourite) {
                    _showOnlyFavourite = true;
                    print(_showOnlyFavourite);
                  } else {
                    _showOnlyFavourite = false;
                    _showOnlyFavourite;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('Favourite'),
                        value: filterOption.favourite),
                    PopupMenuItem(
                      child: Text('All'),
                      value: filterOption.all,
                    )
                  ],
            )
          ],
        ),
        body: ProductGrid(_showOnlyFavourite));
  }
}

class ProductGrid extends StatelessWidget {
  final bool showfavourite;

  ProductGrid(this.showfavourite);

  @override
  Widget build(BuildContext context) {
    final Products = Provider.of<ProductProvider>(context);
    final loadedProducts =showfavourite ? Products.favouriteItems : Products.items;


    if (loadedProducts.length == 0) {
      return Center(
        child: Text(
          "NO FAVOURITE",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
            //cross axis space bt column , main axis spacing bt rows
            ),
        itemCount: loadedProducts.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
            value:loadedProducts[i],
            child: ProductItem(
                /*loadedProducts[i].id,
            loadedProducts[i].title,
            loadedProducts[i].image,*/
                )),
        padding: const EdgeInsets.all(10.0),

      );
    }
  }
}
