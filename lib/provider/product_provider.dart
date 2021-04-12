import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/screens/overview.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../exceptions/exceptions.dart';

class Products with ChangeNotifier {
  final String currentUserToken;
  Products(this.currentUserToken,this._items);
  List<Product> _items = [
    /*
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      favorite: false,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      favorite: false,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      favorite: false,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      favorite: false,
    ),*/
  ];
  var _showFavoritesOnly = false;
  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((element) => element.favorite).toList();
    }
    return [..._items];
  }

  Product matchID(String id) {
    print("item id found with match id");
    print(id);
    return _items.firstWhere((element) => element.id == id);
  }

  void updatedList() {
    notifyListeners();
  }

  List<Product> getFavProducts() {
    return _items.where((element) => element.favorite).toList();
  }

  void showAll() {
    _showFavoritesOnly = false;
    print(_showFavoritesOnly);
    notifyListeners();
  }

  void showFavorites() {
    _showFavoritesOnly = true;
    print(_showFavoritesOnly);
    notifyListeners();
  }

  void updateItem(String id, Product newProduct) async {
    print("item updated");

    final firebaseUrl =
        "https://shopping-613a0-default-rtdb.firebaseio.com/products/$id.json?auth=$currentUserToken";

    var indexToUpdate = _items.indexWhere((element) => element.id == id);

    await http.patch(firebaseUrl,
        body: json.encode({
          "title": newProduct.title,
          "description": newProduct.description,
          "imageUrl": newProduct.imageUrl,
          "price": newProduct.price
        }));

    _items[indexToUpdate] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    var itemIndex = _items.indexWhere((element) => element.id == id);
    print("itemINdex $itemIndex");

    var deletingElement = _items[itemIndex];
    _items.remove(deletingElement);
    final firebaseUrl =
        "https://shopping-613a0-default-rtdb.firebaseio.com/products/$id.json?auth=$currentUserToken";

    final response = await http.delete(firebaseUrl);

    if (response.statusCode >= 400) {
      _items.insert(itemIndex, deletingElement);
      notifyListeners();
      throw HttpException("Error occured");
    }
    deletingElement = null;
  }

  Future<void> fetchProducts() async {
    final fireBaseUrl =
        "https://shopping-613a0-default-rtdb.firebaseio.com/products.json?auth=$currentUserToken";

        print("fetching data from firebase");

    final response = await http.get(fireBaseUrl);
    print(response.body);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    final List<Product> productsReceived = [];
    extractedData.forEach((productID, productData) {
      productsReceived.add(
        Product(
            id: productID,
            title: productData['title'],
            description: productData['description'],
            favorite: false,
            imageUrl: productData['imageUrl'],
            price: productData['price']),
      );
    });
    _items = productsReceived;
    notifyListeners();
    print(productsReceived[0].title);
  }

  Future<void> addNewProduct(Product product) async {
    final firebaseUrl =
        "https://shopping-613a0-defaulwt-rtdb.firebaseio.com/products.json?auth=$currentUserToken";
    try {
      final response = await http.post(firebaseUrl,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "favorite":product.favorite,
          }));

      print("product added lulw");
      print(json.decode(response.body).toString());
      final Product tempProduct = Product(
          description: product.description,
          favorite: product.favorite,
          id: json.decode(response.body).toString(),
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title);
      _items.insert(0, tempProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
