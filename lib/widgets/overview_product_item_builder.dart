import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/product_details.dart';
import '../provider/product.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final String imageUrl;
  //ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetails.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: product.favorite
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
              onPressed: product.toggleFavorite,
            ),
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addCartItem(product.id, product.title, product.price);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Added item to cart"),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () => {cart.deleteElement(product.id)},
                  ),
                ));
              }),
          title: Text(
            product.title,
            textAlign: TextAlign.left,
            softWrap: true,
            style: TextStyle(fontFamily: 'Staatliches'),
          ),
        ),
      ),
    );
  }
}
