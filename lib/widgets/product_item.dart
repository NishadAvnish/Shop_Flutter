import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/products_model.dart';
import 'package:shop4/Provider/cart_provider.dart';
import '../Screen/product_detail_screen.dart';
import '../Provider/AuthProvider.dart';

class ProductItem extends StatelessWidget {
  /*final String id, title, imageurl;

  ProductItem(this.id, this.title, this.imageurl);*/

  @override
  Widget build(BuildContext context) {
    final authData=Provider.of<AuthProvider>(context,listen: false);
    ProductModel loadeditem = Provider.of<ProductModel>(context, listen: false);
    final cartItem = Provider.of<CartProvider>(context, listen: false);

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: Colors.black, width: 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                      arguments: loadeditem.id);
                  /*MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(title)));*/
                },
                child: Image.network(
                  loadeditem.image,
                  fit: BoxFit.fill,
                )),
            footer: GridTileBar(
              leading: Consumer<ProductModel>(
                //consumer is used when you dont want to rebuild whole istead the widget in consumer.
                builder: (context, loadeditem, child) => IconButton(
                    icon: Icon(loadeditem.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      loadeditem.toggleFavourite(authData.token,authData.userId);
                    }),
              ),


              trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_basket,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => {
                        Scaffold.of(context).hideCurrentSnackBar(),
                        cartItem.addItem(loadeditem.id, loadeditem.title, loadeditem.price),

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Product added to Cart"),
                          elevation: 10.0,
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cartItem.removeSingleItem(loadeditem.id);
                            },
                          ),
                        ))
                      }),


              backgroundColor: Colors.black45,
              title: Text(
                loadeditem.title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
