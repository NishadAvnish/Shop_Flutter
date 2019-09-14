import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop4/Provider/OrderProvider.dart';
import 'package:shop4/widgets/OrderItem.dart' as oditem;
import '../widgets/Drawerwidg.dart';


class OrderScreen extends StatelessWidget{
  static const routeName='/OrderScreen';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(child:MyDrawer()),
       appBar: AppBar(title: Text("YOUR ORDERS "),
                      leading: MyDrawer().drawerIcon()),
       body: FutureBuilder(future: Provider.of<OrderProvider>(context,listen: false).fetchOrder(),

        builder: (ctx,dataSnapshot) {
          //(context,dataSnapshot)=>getDataSnapshot(dataSnapshot,context),
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<OrderProvider>(
                builder: (ctx, orderData, child) =>
                    ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) =>
                          oditem.OrderItem(orderData.orders[i]),
                    ),
              );
            }
          }
        },
    )

    );
  }



  getDataSnapshot(dataSnapshot,context) {
    if(dataSnapshot.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
    else{
      if(dataSnapshot.error!=null) {return Center(child: Text("AN ERROR OCCUR") );}
      else if(dataSnapshot==null){return Center(child:Text("no data"));}
      else{
        return
        Consumer<OrderProvider>(builder: (context,ordersItem,child)=>ListView.builder(
            itemCount: ordersItem.orders.length,
            itemBuilder: (context,i)=>oditem.OrderItem(Provider.of<OrderProvider>(context).orders[i])) );
        }
    }
}

}