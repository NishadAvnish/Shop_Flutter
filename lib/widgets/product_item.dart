import 'package:flutter/material.dart';
import '../Screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id, title, imageurl;

  ProductItem(this.id, this.title, this.imageurl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: Colors.black, width: 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: id);

                      /*MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(title)));*/
                },
                child: Image.network(
                  imageurl,
                  fit: BoxFit.fill,
                )),
            footer: GridTileBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: null),
              trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: null),
              backgroundColor: Colors.black54,
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
