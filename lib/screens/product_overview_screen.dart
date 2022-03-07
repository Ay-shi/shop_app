import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_grid.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductOverview extends StatelessWidget {
  //const ProductOverview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping App"),
      ),
      body: ProductGrid(),
    );
  }
}
