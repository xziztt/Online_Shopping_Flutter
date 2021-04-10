import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cartModel.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart';

import '../provider/cart.dart';

import '../widgets/cart_screen_item_builder.dart';

class CartScreen extends StatefulWidget {
  static final routeName = "/cart-screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    final cartItems = cart.cartItems;
    final orders = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Total"),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(
                    backgroundColor: Colors.greenAccent.shade200,
                    label: Text("\$ ${cart.totalPrice.toStringAsFixed(2)}"),
                  ),
                  SizedBox(width: 100),
                  FlatButton(
                    child: Text("Order Now"),
                    onPressed: () {
                      print(cartItems.length);
                      setState(() {
                        orders.addOrder(
                          cartItems.values.toList(),
                          cart.totalPrice,
                        );
                        cartItems.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CartScreenItemBuilder(
                  cartItems.values.toList()[index].id,
                  cartItems.values.toList()[index].price,
                  cartItems.values.toList()[index].title,
                  cartItems.values.toList()[index].quantity,
                );
              },
              itemCount: cart.itemNos(),
            ),
          )
        ],
      ),
    );
  }
}
