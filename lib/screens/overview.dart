import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/product_provider.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/widgets/drawer.dart';

import '../provider/product.dart';
import '../widgets/gridViewBuild.dart';
import '../widgets/overview_product_item_builder.dart';
import '../widgets/badge.dart';
import '../provider/cart.dart';

import 'package:provider/provider.dart';

final List<Product> productList = [];
enum FilterProductOverview {
  Favorites,
  All,
}

class Overview extends StatefulWidget {
  static const routeName = "/";
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  bool _isInit = false;
  bool _isLoading = true;
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit == false) {
      Provider.of<Products>(context).fetchProducts();
    }
    _isInit = true;
    _isLoading = false;
    super.didChangeDependencies();
  }

  var _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerLeft(),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterProductOverview value) {
              setState(() {
                print(value);
                if (value == FilterProductOverview.Favorites) {
                  _showFavoritesOnly = true;
                } else if (value == FilterProductOverview.All) {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Favorites"),
                value: FilterProductOverview.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterProductOverview.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) {
              return Badge(
                  child: child,
                  value: cart.itemNos().toString(),
                  color: Colors.red);
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
        backgroundColor: Colors.greenAccent.shade200,
        title: Text(
          "Shopping",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ))
          : Container(
              padding: EdgeInsets.all(5),
              child: GridViewBuild(_showFavoritesOnly),
            ),
    );
  }
}
