import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../provider/auth.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool favorite;
  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.favorite});
  // add @required if anything is required compulsorily
  void setFav(bool favStatus) {
    favorite = favStatus;
    notifyListeners();
  }

  Future<void> toggleFavorite(String currentUserToken) async {
    bool beforeStatus = favorite;
    favorite = !favorite;
    notifyListeners();
    final Uri firebaseUrl = Uri.parse(
        "https://shopping-613a0-defaulwt-rtdb.firebaseio.com/products.json?auth=$currentUserToken");
    try {
      final response = await http.patch(firebaseUrl,
          body: json.encode({"favorite": favorite}));

      if (response.statusCode >= 400) {
        setFav(beforeStatus);
      }
    } catch (error) {
      setFav(beforeStatus);
    }
  }
}
