import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/AuthProvider.dart';
import 'package:shop4/Screen/OrderScreen.dart';
import 'package:shop4/Screen/ProductsScreen.dart';
import 'package:shop4/Screen/UserProductScreen.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<IconData>icon = [Icons.shop, Icons.payment,Icons.edit,Icons.exit_to_app];
    List<String> name = ['Shop', "Order",'ManageProduct','LogOut'];

    return Column(

            children: <Widget>[
              AppBar(title: Text("Hello Friends"),
                  leading: Builder(builder: (context) =>
                      IconButton(
                          icon: Icon(Icons.clear_all, color: Colors.amber),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }))),

              Divider(color: Colors.red,),

              Expanded( child:ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(icon[0]),
                    title: Text(name[0]),
                    onTap: (){// Navigator.of(context).pushNamed('/') or;
                            //Navigator.of(context).pop(false);
                             Navigator.of(context).pushReplacementNamed(ProductScreen.routeName);
                             },

                  ),


                  Divider(),
                  ListTile(
                    leading: Icon(icon[1]),
                    title: Text(name[1]),
                    onTap:(){
                      Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
                    }
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(icon[2]),
                    title: Text(name[2]),
                    onTap:(){
                      Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
                    }
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(icon[3]),
                    title: Text(name[3]),
                    onTap: (){
                      Navigator.of(context).pop(false);
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                      Provider.of<AuthProvider>(context,listen: false).logout();
                    },

                  ),

                  Divider(),

                ],
              ),),

            ],

      );
  }
  Builder drawerIcon() {
    return Builder(builder: (context) {
      return IconButton(
          icon: Icon(
            Icons.clear_all,
            color: Colors.amber,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();

            //_scaffoldKey.currentState.openDrawer();
          }

      );
    },);
  }
}