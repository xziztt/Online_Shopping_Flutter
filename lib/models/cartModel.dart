import 'package:flutter/cupertino.dart';

class CartModel {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartModel(
      {@required this.id,
      @required this.title,
      this.quantity,
      @required this.price});
}
