import 'package:flutter/material.dart';
import 'package:shop4/Provider/cart_provider.dart';
import 'package:shop4/Provider/product_provider.dart';
import 'package:shop4/widgets/Drawerwidg.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import 'cartscreen.dart';


enum filterOption {
  favourite,
  all,
}

class ProductScreen extends StatefulWidget {
  static const routeName='/productscreen';
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  var _showOnlyFavourite = false;
  var _init=true;
  var _loading=false;

  @override
  void initState(){
    super.initState();
  }


  @override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _loading=true;
      });
      Provider.of<ProductProvider>(context).fetchShow().then((_){
        _loading=false;
      });
    }
    _init=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
        drawer: Drawer(elevation: 10,child: MyDrawer(),),
        appBar: AppBar(
          title: Text('MYSHOP'),
          leading: MyDrawer().drawerIcon(),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (filterOption selectedValue) {
                setState(() {
                  if (selectedValue == filterOption.favourite) {
                    _showOnlyFavourite = true;
                  } else {
                    _showOnlyFavourite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) =>
              [
                PopupMenuItem(
                    child: Text('Favourite'), value: filterOption.favourite),
                PopupMenuItem(
                  child: Text('All'),
                  value: filterOption.all,
                )
              ],
            ),
            Consumer<CartProvider>(builder: (_, cartitem, ch) =>
                Badge(
                  child: ch,
                  value: cartitem.itemCount.toString(),
                ),

              //now the IconButton doesn't rebuild ...
              child: IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: () =>
                {
                  Navigator.of(context).pushNamed(CartScreenState.routeName)
                },
              ),
            ),
          ],
        ),
        body: _loading?Center(child:CircularProgressIndicator()):ProductGrid(_showOnlyFavourite));
  }
}




class ProductGrid extends StatelessWidget {
  final bool showfavourite;

  ProductGrid(this.showfavourite);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final loadedProducts = showfavourite ? products.favouriteItems : products
        .items;

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
            childAspectRatio: 3 / 2.3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
          //cross axis space bt column , main axis spacing bt rows
        ),
        itemCount: loadedProducts.length,
        itemBuilder: (context, i) =>
            ChangeNotifierProvider.value(
                value: loadedProducts[i],
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
