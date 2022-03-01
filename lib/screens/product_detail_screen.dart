import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  //const ProductDetailScreen({ Key? key }) : super(key: key);
  static const String routeName = "/product_detail";

  final title;
  const ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
