import 'package:flutter/material.dart';
import 'package:shop_app/screens/manage_user_products.dart';
import 'package:shop_app/screens/orders_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

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
                  .pushReplacementNamed(OrdersScreen.namedRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProdutsScreen.routename);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: Provider.of<Auth>(context).logOut,
          )
        ],
      ),
    );
  }
}
