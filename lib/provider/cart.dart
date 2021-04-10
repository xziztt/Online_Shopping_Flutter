import 'package:flutter/material.dart';
import 'package:flutter_shop/widgets/overview_product_item_builder.dart';
import '../models/cartModel.dart';

class Cart with ChangeNotifier {
  Map<String, CartModel> cartItems = {};
  Map<String, CartModel> get items {
    return {...cartItems};
  }

  void addCartItem(String id, String title, double price) {
    print(price);
    if (cartItems.containsKey(id)) {
      cartItems.update(
          id,
          (value) => CartModel(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      cartItems.putIfAbsent(
        id,
        () => CartModel(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price),
      );
    }
    notifyListeners();
  }

  void deleteElement(String id) {
    if (cartItems.containsKey(id)) {
      if (cartItems[id].quantity == 1) {
        print(cartItems[id].title);
        cartItems.remove(id);
      } else if (cartItems[id].quantity > 1) {
        cartItems.update(
            id,
            (value) => CartModel(
                id: value.id,
                title: value.title,
                quantity: value.quantity - 1,
                price: value.price));
      }
    }
    notifyListeners();
    return;
  }

  double get totalPrice {
    var total = 0.0;
    cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int itemNos() {
    print(cartItems.length);
    //returns the no of items in the cart
    return cartItems.length;
  }

  void removeItem(String productId) {
    cartItems.removeWhere((key, value) => value.id == productId);
    notifyListeners();
  }
}
