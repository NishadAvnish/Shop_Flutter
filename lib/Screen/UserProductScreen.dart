import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Screen/EditUserProduct.dart';
import 'package:shop4/widgets/Drawerwidg.dart';
import 'package:shop4/widgets/UserProductItem.dart';
import '../Provider/product_provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchShow(true);
  }

  @override
  Widget build(BuildContext context) {
    //final prodItem = Provider.of<ProductProvider>(context).items;
    return Scaffold(
        appBar: AppBar(
          title: Text("YOUR PRODUCT"),
          leading: MyDrawer().drawerIcon(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, EditUserProduct.routeName);
              },
            ),
          ],
        ),
        drawer: Drawer(
          elevation: 10,
          child: MyDrawer(),
        ),
        body: FutureBuilder(
            future: _refreshProducts(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Consumer<ProductProvider>(
                          builder: (ctx,prodItem,_)=>
                           Padding(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                              itemCount: prodItem.items.length,
                              itemBuilder: (ctx, i) {
                                return UserProductItem(prodItem.items[i].title,
                                    prodItem.items[i].image, prodItem.items[i].id);
                              },
                            ),
                          ),
                        ),
                )));
  }
}
