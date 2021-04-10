import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/edit_products_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ManageProductItemBuilder extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  ManageProductItemBuilder(this.id, this.title, this.imageUrl);

  @override
  _ManageProductItemBuilderState createState() =>
      _ManageProductItemBuilderState();
}

class _ManageProductItemBuilderState extends State<ManageProductItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: Container(
          height: 60,
          width: 60,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(widget.imageUrl)),
        ),
        title: Text(widget.title),
        trailing: Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: widget.id),
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => Provider.of<Products>(context, listen: false)
                      .deleteProduct(widget.id)),
            ],
          ),
        ),
      ),
    );
  }
}
