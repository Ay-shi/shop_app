import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import '../providers/cart_item.dart';
import '../screens/cart_item_screen.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routename = "/cart_screen";
  //const CartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(children: [
          Card(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    "\$${cart.totalCost().toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                orderButton(cart: cart, cartItems: cartItems)
              ],
            ),
          )),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) {
              return ci.CartItem(
                title: cartItems[i].title,
                quantity: cartItems[i].quantity,
                price: cartItems[i].price,
                id: cartItems[i].id,
                productId: cart.items.keys.toList()[i],
              );
            },
            itemCount: cart.itemCount,
          ))
        ]));
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key? key,
    required this.cart,
    required this.cartItems,
  }) : super(key: key);

  final Cart cart;
  final List<CartItem> cartItems;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return TextButton(
        onPressed: widget.cart.totalCost() <= 0
            ? null
            : () async {
                try {
                  final orders = Provider.of<Orders>(context, listen: false);
                  setState(() {
                    isLoading = true;
                  });
                  await orders.add(widget.cartItems, widget.cart.totalCost());
                  setState(() {
                    isLoading = false;
                  });
                  widget.cart.clearCart();
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      content: Text("error occured while placing order")));
                }
              },
        child: isLoading ? CircularProgressIndicator() : Text("ORDER NOW!"));
  }
}
