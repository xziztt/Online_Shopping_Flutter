import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartScreenItemBuilder extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;

  CartScreenItemBuilder(this.id, this.price, this.title, this.quantity);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Cart>(context);
    print(price);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        product.removeItem(id);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Confirm"),
                  content: Text("Do you want to remove itme from the cart ?"),
                  actions: [
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    FlatButton(
                      child: Text("No"),
                      onPressed: () => Navigator.of(context).pop(false),
                    )
                  ],
                ));
      },
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
      ),
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: FittedBox(
              child: CircleAvatar(
                child: Text("\$${price}"),
              ),
            ),
            title: Text("${title}"),
            subtitle: Text("Total + ${(quantity * price)}"),
            trailing: Text("Quantity: x${quantity}"),
          ),
        ),
      ),
    );
  }
}
