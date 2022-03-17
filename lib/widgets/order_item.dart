import 'package:flutter/material.dart';
import "../providers/orders.dart" as oi;
import "package:intl/intl.dart";
import 'dart:math';

class OrderItem extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);
  final oi.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          child: ListTile(
        title: Text("\$${widget.order.amount}"),
        subtitle: Text(
          ("${DateFormat.yMMMEd().format(widget.order.date)}"),
        ),
        trailing: IconButton(
          icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          onPressed: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
      )),
      if (_expanded)
        Container(
            color: Colors.white54,
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: min(widget.order.products.length * 15.0 + 10, 150),
            child: ListView(
              children: widget.order.products.map((prod) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(prod.title),
                      Text("${prod.price}x ${prod.quantity}")
                    ]);
              }).toList(),
            ))
    ]);
  }
}
