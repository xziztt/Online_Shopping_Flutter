import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/product_details.dart';

import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/product_provider.dart';
import 'overview_product_item_builder.dart';

class GridViewBuild extends StatelessWidget {
  final bool isShowFav;
  GridViewBuild(this.isShowFav);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    final List<Product> productList =
        isShowFav == true ? product.getFavProducts() : product.items;
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: ProductItem(),
          );
        });
  }
}
