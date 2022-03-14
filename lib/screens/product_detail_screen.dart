import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  //const ProductDetailScreen({ Key? key }) : super(key: key);
  static const String routeName = "/product_detail";

  // final title;
  // const ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findProd(productId);
    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                loadedProduct.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                loadedProduct.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                loadedProduct.description,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[350],
                    fontSize: 15),
                softWrap: true,
              )
            ],
          ),
        ));
  }
}
