import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import '../Provider/product_provider.dart';

class ProductDetailWidget extends StatelessWidget {
 final item;


 ProductDetailWidget(this.item);

 @override
  Widget build(BuildContext context) {

    // TODO: implement build


    return SafeArea(
        child: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(child:Padding(padding:EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Image.network(item.image), fit: BoxFit.contain,),)),

                SizedBox(height: 12.0,),

                Text(item.title,style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),

                SizedBox(height: 12.0,),
                Text(item.description,textAlign:TextAlign.center,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),)


          ],
    ),

    )));
  }

}