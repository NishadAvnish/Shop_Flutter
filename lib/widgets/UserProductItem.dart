import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/product_provider.dart';
import 'package:shop4/Screen/EditUserProduct.dart';

class UserProductItem extends StatefulWidget{
  final String title, imageUrl,id;

  UserProductItem(this.title, this.imageUrl,this.id);

  @override
  State<StatefulWidget> createState() {

    return UserProductItemState(title, imageUrl, id);
  }

}


class UserProductItemState extends State<UserProductItem> {
  final String title, imageUrl,id;

  UserProductItemState(this.title, this.imageUrl,this.id);

  var _isLoading=false;

  void _loadingBar(BuildContext context){
   setState(() {
     _isLoading=true;
   });

    Provider.of<ProductProvider>(context).removeItem(id).then((_){
      setState(() {
        _isLoading=false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return
      Column(
        children: <Widget>[
          ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.transparent,
          ),
          trailing: Container(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditUserProduct.routeName, arguments: id);
                    },
                  ),
                  _isLoading?Center(child: CircularProgressIndicator(),):IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: (){
                        _loadingBar(context);
                      }


                  )
                ],
              )),

    ),
          Divider(),
        ],
      );
  }
}
