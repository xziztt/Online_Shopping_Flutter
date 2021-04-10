import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/product.dart';
import 'package:flutter_shop/provider/product_provider.dart';
import 'package:flutter_shop/screens/manage_products_screen.dart';
import 'package:intl/number_symbols_data.dart';

import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-products-screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  final _formKey = GlobalKey<FormState>();
  final _priceNode = FocusNode();
  Product _currentlyEditingItem = Product(
    id: null,
    description: "",
    favorite: false,
    imageUrl: "",
    price: 0,
    title: "",
  );

  final _descriptionNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_imageUrlListen);
    super.initState();
  }

  var _didChange = true;

  void didChangeDependencies() {
    if (_didChange == true) {}
    _didChange = false;
    super.didChangeDependencies();
  }

  void _imageUrlListen() {
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  void _submitForm() {
    final isValidated = _formKey.currentState.validate();
    print(_currentlyEditingItem.id);
    print("here");

    if (_currentlyEditingItem.id != null) {
      print("item already exists");
      Provider.of<Products>(context, listen: true).updateItem(
        _currentlyEditingItem.id,
        _currentlyEditingItem,
      );

      //add new
    } else {
      print("product does not exist");
      print(_currentlyEditingItem.id);
      Provider.of<Products>(context, listen: true)
          .addNewProduct(_currentlyEditingItem);
    }
    if (!isValidated) {
      return;
    }

    _formKey.currentState.save();
  }

  void dispose() {
    _imageUrlController.dispose();
    _priceNode.dispose();
    _priceNode.dispose();
    _imageUrlFocusNode.removeListener(_imageUrlListen);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String passedId = ModalRoute.of(context).settings.arguments as String;
    if (passedId != null) {
      final Product _currentlyEditingItem =
          Provider.of<Products>(context, listen: false).matchID(passedId);
      print("replaced with existing item");
      print("existing products id is ");
      print(_currentlyEditingItem.id);

      _initValues = {
        'title': _currentlyEditingItem.title,
        'description': _currentlyEditingItem.description,
        'price': _currentlyEditingItem.price.toString(),
        'imageUrl': _currentlyEditingItem.imageUrl,
      };
      _imageUrlController.text = _currentlyEditingItem.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("before passing");
                print(_currentlyEditingItem.id);
                _submitForm();
              }),
        ],
        backgroundColor: Colors.greenAccent.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"].toString(),
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    (FocusScope.of(context).requestFocus(_priceNode)),
                validator: (value) {
                  if (!value.isEmpty) {
                    return null;
                  } else {
                    return ("Input a valid title");
                  }
                },
                onSaved: (value) {
                  _currentlyEditingItem = Product(
                      description: _currentlyEditingItem.description,
                      favorite: _currentlyEditingItem.favorite,
                      id: _currentlyEditingItem.id,
                      imageUrl: _currentlyEditingItem.imageUrl,
                      price: _currentlyEditingItem.price,
                      title: value);
                },
              ),
              TextFormField(
                  initialValue: _initValues["price"].toString(),
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Price is required";
                    }
                    if (double.tryParse(value) == null) {
                      return "Invalid Characters found";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _currentlyEditingItem = Product(
                        description: _currentlyEditingItem.description,
                        favorite: _currentlyEditingItem.favorite,
                        id: _currentlyEditingItem.id,
                        imageUrl: _currentlyEditingItem.imageUrl,
                        price: double.parse(value),
                        title: value);
                  }),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: InputDecoration(labelText: "Description"),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.number,
                focusNode: _descriptionNode,
                onSaved: (value) {
                  _currentlyEditingItem = Product(
                      description: value,
                      favorite: _currentlyEditingItem.favorite,
                      id: _currentlyEditingItem.id,
                      imageUrl: _currentlyEditingItem.imageUrl,
                      price: _currentlyEditingItem.price,
                      title: value);
                },
                validator: (value) {
                  if (value.length < 10) {
                    return "Description must be atleast 10 characters";
                  }
                  if (value.isEmpty) {
                    return "Description must not be empty";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text("Enter a Url")
                        : Image.network(_imageUrlController.text),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      validator: (value) {
                        /* if (!(value.endsWith("jpg")) &&
                           !(value.endsWith("png") &&
                                !(value.endsWith("jpeg")))) {
                          return "Valid image types: jpg,png,jpeg";
                        }
                        if (!value.startsWith("http") &&
                            !value.startsWith("https")) {
                          return "Not a valid image";
                        }*/
                        return null;
                      },
                      onFieldSubmitted: (_) => _submitForm(),
                      focusNode: _imageUrlFocusNode,
                      onSaved: (value) {
                        _currentlyEditingItem = Product(
                          description: _currentlyEditingItem.description,
                          favorite: _currentlyEditingItem.favorite,
                          id: _currentlyEditingItem.id,
                          imageUrl: value,
                          price: _currentlyEditingItem.price,
                          title: value,
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
