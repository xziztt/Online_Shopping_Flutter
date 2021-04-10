import 'package:flutter/foundation.dart';
import 'package:flutter_shop/models/cartModel.dart';
import 'package:flutter_shop/provider/cart.dart';

class OrdersItem {
  final String id;
  final double total;
  final List<CartModel> orderedItems;
  final DateTime orderedTime;
  OrdersItem({this.id, this.total, this.orderedItems, this.orderedTime});
}

class Orders with ChangeNotifier {
  List<OrdersItem> orders = [];
  List<OrdersItem> get ordersGet {
    return [...orders];
  }

  void addOrder(List<CartModel> cartItems, double totalAmount) {
    orders.insert(
      0,
      OrdersItem(
          id: DateTime.now().toString(),
          total: totalAmount,
          orderedItems: cartItems,
          orderedTime: DateTime.now()),
    );
    notifyListeners();
  }
}
