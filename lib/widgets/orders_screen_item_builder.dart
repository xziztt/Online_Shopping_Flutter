import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/orders.dart';
import '../screens/orders_screen.dart';
import 'package:intl/intl.dart';

class OrdersScreenItemBuilder extends StatefulWidget {
  final OrdersItem orderedItem;

  OrdersScreenItemBuilder(this.orderedItem);

  @override
  _OrdersScreenItemBuilderState createState() =>
      _OrdersScreenItemBuilderState();
}

class _OrdersScreenItemBuilderState extends State<OrdersScreenItemBuilder> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title:
                Text("No of items: ${widget.orderedItem.orderedItems.length}"),
            subtitle: Text(
              DateFormat("On dd/MM/yy At hh:mm ")
                  .format(widget.orderedItem.orderedTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !(_isExpanded);
                  print(_isExpanded);
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              height: ((widget.orderedItem.orderedItems.length) * 20.0 + 80),
              child: ListView.builder(
                itemCount: widget.orderedItem.orderedItems.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.greenAccent.shade100,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${widget.orderedItem.orderedItems[index].title}"),
                            Text(
                                " ${widget.orderedItem.orderedItems[index].quantity}x${widget.orderedItem.orderedItems[index].price} \$ "),
                          ],
                        ),
                      ));
                },
              ),
            )
        ],
      ),
    );
  }
}
