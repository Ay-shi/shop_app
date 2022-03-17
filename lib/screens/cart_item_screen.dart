import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_item.dart';

class CartItem extends StatelessWidget {
  // const CartItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;

  CartItem(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        cart.removeProduct(productId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.grey,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("\$$price"),
            )),
            radius: 40,
          ),
          title: Text(title),
          subtitle: Text("Total: \$${price * quantity}"),
          trailing: Text("${quantity}x"),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you really want to delete this?"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Yes")),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("No")),
                ],
              );
            });
      },
    );
  }
}
