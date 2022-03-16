import 'package:flutter/material.dart';
import "../providers/orders.dart" as oi;
import "package:intl/intl.dart";

class OrderItem extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);
  final oi.OrderItem order;
  OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text("\$${order.amount}"),
      subtitle: Text(
        ("${DateFormat.yMMMEd().format(order.date)}"),
      ),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
    ));
  }
}
