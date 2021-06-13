import 'package:flutter/material.dart';
import 'edit_products_screen.dart';
import 'package:flutter_shop/widgets/drawer.dart';
import '../widgets/manage_products_item_builder.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = "/manage-products";

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  Future<void> _refreshItems(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerLeft(),
      appBar: AppBar(
        title: Text("Manage Items"),
        backgroundColor: Colors.greenAccent.shade200,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshItems(context),
        builder: (context,snapshot) => snapshot.connectionState == ConnectionState.waiting? Center(child: CircularProgressIndicator(),): RefreshIndicator(
          onRefresh: () => _refreshItems(context),
          child: Consumer<Products>(
            builder: (context,productDetails,_) =>
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListView.builder(
                itemCount: productDetails.items.length,
                itemBuilder: (context, index) {
                  return ManageProductItemBuilder(productDetails.items[index].id,
                      productDetails.items[index].title, productDetails.items[index].imageUrl);
                },
            ),
             ),
          ),
        ),
      ),
    );
  }
}
