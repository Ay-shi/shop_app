import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screem.dart';
import 'package:shop_app/screens/manage_user_products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/cart_item.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent),
            scaffoldBackgroundColor: Colors.teal,
            colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: Colors.deepPurpleAccent, tertiary: Colors.white),
            fontFamily: 'Lato'),
        home: AuthScreen(),
        routes: {
          UserProdutsScreen.routename: (ctx) => UserProdutsScreen(),
          CartScreen.routename: (ctx) => CartScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrdersScreen.namedRoute: (ctx) => OrdersScreen(),
          EditProduct.routename: (ctx) => EditProduct(),
          ProductOverview.routename: (ctx) => ProductOverview(),
        },
      ),
    );
  }
}
