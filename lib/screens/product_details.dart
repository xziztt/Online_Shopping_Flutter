import 'package:flutter/material.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product_details';
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final currentProduct = Provider.of<Products>(context).matchID(productID);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent.shade200,
          title: Text(
            currentProduct.title,
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 400,
                  child: Image.network(
                    currentProduct.imageUrl,
                  ),
                ),
                Positioned(
                  left: 360,
                  bottom: 20,
                  child: Container(
                    child: Text(
                      "\$${currentProduct.price}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "${currentProduct.description}",
              softWrap: true,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
