import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/manage_products_screen.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import './drawer_tile_builder.dart';
import '../screens/orders_screen.dart';

import '../screens/overview.dart';

class DrawerLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.greenAccent.shade200,
            title: Text("Options"),
          ),
          Divider(),
          DrawerItemBuilder(
              "HOME",
              () => Navigator.of(context)
                  .pushReplacementNamed(Overview.routeName)),
          DrawerItemBuilder(
              "ORDERS",
              () => Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName)),
          DrawerItemBuilder(
            "Manage Products",
            () => Navigator.of(context)
                .pushReplacementNamed(ManageProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
