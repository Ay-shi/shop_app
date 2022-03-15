import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  //const OrdersClass({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("orders"),
      ),
      body: ListView.builder(
        itemBuilder: (cntx, i) {
          return OrderItem(orders[i]);
        },
        itemCount: orders.length,
      ),
    );
  }
}
