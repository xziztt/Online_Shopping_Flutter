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
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, index) {
          return OrdersScreenItemBuilder(ordersProvider.orders[index]);
        },
      ),
    );
  }
}
