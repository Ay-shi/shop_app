import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/cart_item.dart';

import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart())
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent),
            scaffoldBackgroundColor: Colors.teal,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Colors.deepPurpleAccent),
            fontFamily: 'Lato'),
        home: ProductOverview(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
