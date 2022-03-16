import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

class DrawerScreen extends StatelessWidget {
  //const Drawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Center(child: Text("Hello user!!"))),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context)
                  .restorablePushReplacementNamed(OrdersScreen.namedRoute);
            },
          )
        ],
      ),
    );
  }
}
