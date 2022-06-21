import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
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
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (context, auth, previousProduct) => Products(
                  previousProduct == null ? [] : previousProduct.items,
                  auth.token,
                  auth.getUserId()),
              create: (context) => Products([], null, null)),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
              update: (context, auth, previous) =>
                  Orders(auth.token, previous == null ? [] : previous.orders),
              create: (context) => Orders(null, []))
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'MyShop',
                  theme: ThemeData(
                      primarySwatch: Colors.pink,
                      appBarTheme: AppBarTheme(color: Colors.pinkAccent),
                      //scaffoldBackgroundColor: Colors.teal,
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                          secondary: Color.fromARGB(255, 240, 194, 95),
                          tertiary: Colors.white),
                      fontFamily: 'Lato'),
                  home: auth.isAuth ? ProductOverview() : AuthScreen(),
                  routes: {
                    UserProdutsScreen.routename: (ctx) => UserProdutsScreen(),
                    CartScreen.routename: (ctx) => CartScreen(),
                    ProductDetailScreen.routeName: (ctx) =>
                        ProductDetailScreen(),
                    OrdersScreen.namedRoute: (ctx) => OrdersScreen(),
                    EditProduct.routename: (ctx) => EditProduct(),
                    ProductOverview.routename: (ctx) => ProductOverview(),
                  },
                ))
        // MaterialApp(
        //   title: 'MyShop',
        //   theme: ThemeData(
        //       primarySwatch: Colors.teal,
        //       appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent),
        //       scaffoldBackgroundColor: Colors.teal,
        //       colorScheme: ColorScheme.fromSwatch().copyWith(
        //           secondary: Colors.deepPurpleAccent, tertiary: Colors.white),
        //       fontFamily: 'Lato'),
        //   home: AuthScreen(),
        //   routes: {
        //     UserProdutsScreen.routename: (ctx) => UserProdutsScreen(),
        //     CartScreen.routename: (ctx) => CartScreen(),
        //     ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        //     OrdersScreen.namedRoute: (ctx) => OrdersScreen(),
        //     EditProduct.routename: (ctx) => EditProduct(),
        //     ProductOverview.routename: (ctx) => ProductOverview(),
        //   },
        // ),
        );
  }
}
