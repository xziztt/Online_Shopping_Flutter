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
    await Provider.of<Products>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productDetails = Provider.of<Products>(context).items;
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
      body: RefreshIndicator(
        onRefresh: () => _refreshItems(context),
        child: ListView.builder(
          itemCount: productDetails.length,
          itemBuilder: (context, index) {
            return ManageProductItemBuilder(productDetails[index].id,
                productDetails[index].title, productDetails[index].imageUrl);
          },
        ),
      ),
    );
  }
}
