import 'package:flutter/material.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product_details';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productID = ModalRoute.of(context).settings.arguments as String;
    final currentProduct = Provider.of<Products>(context).matchID(productID);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.greenAccent.shade200,Colors.white],
          begin: Alignment.bottomCenter,
          end: Alignment.bottomRight


        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.greenAccent.shade200,
            title: Text(
              currentProduct.title,
              style: TextStyle(color: Colors.black),
            ),
            actions: [IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
              cart.addCartItem(currentProduct.id,currentProduct.title,currentProduct.price);
            })],),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                  
                    alignment: Alignment.center,
                    width: double.infinity,
                   
                    child: Image.network(
                      currentProduct.imageUrl,
                    ),
                  ),
                  Container(
                    child: Positioned(
                      bottom: 20,
                      top: 200,
                      

                      child: Container(

                        color: Colors.black45,
                        child: Text(
                          "\$${currentProduct.price}",
                          style: TextStyle(fontSize: 100,color: Colors.white),
                        ),
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
      ),
    );
  }
}
