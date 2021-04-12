import 'package:flutter/material.dart';
import 'package:flutter_shop/widgets/drawer.dart';
import 'package:flutter_shop/widgets/orders_screen_item_builder.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders-screen";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
      drawer: DrawerLeft(),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        title: Text("Orders"),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context).fetchOrders(),
        builder: (context,snapshot){ //FutureBuilder takes a snapshot after the future returns a value and rebuilds the widget with that snapshot
     if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else{
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
 } 
            
            return Consumer<Orders>(builder: (context,order,widget){
              
             return ListView.builder(itemBuilder: (context,item){
               print("orders building");
               return OrdersScreenItemBuilder(order.orders[item]);
              },
              itemCount: order.orders.length,);
            },);
          }
          

      },
      
    ),);
  }
}
