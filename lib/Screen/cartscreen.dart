
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/cart_provider.dart';
import 'package:shop4/widgets/CartItem.dart';
import 'package:shop4/widgets/sliverExpandableAreaWidget.dart';


class CartScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartScreenState();
  }}

  class CartScreenState extends State<CartScreen>{

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {

   final cart=Provider.of<CartProvider>(context);



    return MaterialApp(
      home:Scaffold(
        //appBar: AppBar(title:Center( child:Text('CART',style: TextStyle(fontFamily:'Teko',fontSize: 20*scaleFactor ),),)),

        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
             leading: IconButton(icon:Icon(Icons.arrow_back),
             onPressed:() => Navigator.pop(context, false),
                ),

              expandedHeight: 120,
              elevation: 12,
              pinned: true,
              floating:true,

              flexibleSpace:LayoutBuilder(builder: (BuildContext context,BoxConstraints constraint){
                double height=constraint.biggest.height;
                return (FlexibleSpaceBar(
                 /* title: Text('$height'),*/
                  //centerTitle:true,
                  title: isExtanded(height)? Text(""):Text("CART",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Teko'
                      )),
                  background:SliverExpandableAreaWidget(),

                ));
              },),
             ),


           SliverList(
           delegate:SliverChildBuilderDelegate(


             (BuildContext context,int i){

               return CartItemWidget(cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title,);


           },
             childCount:cart.items.length,
           )

           )

          ],
        )

        ),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          cursorColor: Colors.purpleAccent,
          primaryColorDark: Colors.white,
          fontFamily: 'Teko'),
      );

  }

  bool isExtanded(double height){
      if(height<89) return false;

      else return true;
  }




}