import 'package:flutter/foundation.dart';
import 'package:flutter_shop/models/cartModel.dart';
import 'package:flutter_shop/provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final String currentUserToken;
  Orders(this.currentUserToken,this.orders);
  List<OrdersItem> fetchedOrders = [];
  Future<void> fetchOrders() async{
    final firebaseUrl = "https://shopping-613a0-default-rtdb.firebaseio.com/orders.json?auth=$currentUserToken";
    final response = await http.get(firebaseUrl);
    
    //print(response.body);
    final responseOrderItems = json.decode(response.body) as Map<String,dynamic>;
    if(responseOrderItems == null){
      return;
    }
      responseOrderItems.forEach((id, value) {
         print(fetchedOrders);

        
        print(value["Items"][0]["id"]);
        fetchedOrders.insert(0,OrdersItem(
          id: id,
          total:value["amount"],
          orderedItems: (value["Items"] as List<dynamic>).map((e){
            return CartModel(id: e["id"].toString(), title: e["title"], price: e["price"],quantity: e["quantitiy"]);
          }).toList(),
          orderedTime: DateTime.parse(value["dateAndTime"]),
          
        ));
       

        
       });


        

    
    
  }




  void addOrder(List<CartModel> cartItems, double totalAmount) async{  //use Future<void> if you need to return a future.
    final firebaseUrl = "https://shopping-613a0-default-rtdb.firebaseio.com/orders.json?auth=$currentUserToken";
    final orderTimeDate = DateTime.now();
    
    final response = await http.post(firebaseUrl,body: json.encode({ 
      "dateAndTime":orderTimeDate.toIso8601String(),
      "amount":totalAmount,
      "Items": cartItems.map((e) => {
        "id":e.id,
        "title":e.title,
        "quantitiy":e.quantity,
        "price":e.price,
      }).toList(),  //cannot directly post the products.convert it into a list of items
    }));
    print("order_response");
    print(response.body);
    

    orders.insert(  //use the response id as the id for the order
      0,
      OrdersItem(
          id: json.decode(response.body)["name"],
          total: totalAmount,
          orderedItems: cartItems,
          orderedTime: orderTimeDate),
    );
    notifyListeners();
  }
}
