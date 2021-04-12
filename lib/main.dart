import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/provider/auth.dart';
import './provider/product.dart';
import './screens/edit_products_screen.dart';
import './screens/manage_products_screen.dart';
import './screens/orders_screen.dart';
import 'screens/overview.dart';
import 'provider/product_provider.dart';
import 'screens/product_details.dart';
import 'package:provider/provider.dart';
import './provider/orders.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';

import 'provider/cart.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.greenAccent.shade200,
    systemNavigationBarColor: Colors.greenAccent.shade200,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>(
          create: null,
         update: (context,auth,productLast){
           return Products(auth.token,productLast == null ? []: productLast.items); //productLast will be null the first time
         },
        ),
        ChangeNotifierProvider(

          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth,Orders>(
          create: null,
          update: (context,auth,orderLast) => Orders(auth.token,orderLast == null?[]:orderLast.orders),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx,auth,_) => MaterialApp( //basically each time auth is changed the materialApp has to be rebuit.
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Staatliches',
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.green,
        ),
        home: auth.isAuthenticated()?Overview():AuthScreen(),
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          ManageProductsScreen.routeName: (context) => ManageProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),) 
    );
  }
}
