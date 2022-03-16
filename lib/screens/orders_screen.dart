import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/screens/drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  //const OrdersClass({ Key? key }) : super(key: key);
  static const String namedRoute = "/orders";
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("orders"),
      ),
      drawer: DrawerScreen(),
      body: ListView.builder(
        itemBuilder: (cntx, i) {
          return OrderItem(orders[i]);
        },
        itemCount: orders.length,
      ),
    );
  }
}
