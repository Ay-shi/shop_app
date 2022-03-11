import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_item.dart';

class CartScreen extends StatelessWidget {
  //const CartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(children: [
          Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontSize: 20)),
            ],
          ))
        ]));
  }
}
