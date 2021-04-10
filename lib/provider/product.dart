import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

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
  void toggleFavorite() {
    favorite = !favorite;
    notifyListeners();
  }
}
