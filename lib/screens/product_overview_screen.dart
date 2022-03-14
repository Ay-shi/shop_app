import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_item.dart';
import 'package:shop_app/screens/cart_screem.dart';
import 'package:shop_app/widgets/product_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
// import '../models/product.dart';
// import '../widgets/product_item.dart';

enum filterOptions { favouritesOnly, showAll }

class ProductOverview extends StatefulWidget {
  //const ProductOverview({ Key? key }) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool showFav = false;
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping App"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == filterOptions.favouritesOnly) {
                  showFav = true;
                } else
                  showFav = false;
              });

              // if (value == filterOptions.favouritesOnly) {
              //   productsContainer.setShowFavourite();
              // } else
              //   productsContainer.setShowAll();
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Show favourites only"),
                value: filterOptions.favouritesOnly,
              ),
              PopupMenuItem(
                child: Text("Show all"),
                value: filterOptions.showAll,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routename);
                }),
          ),
        ],
      ),
      body: ProductGrid(showFav),
    );
  }
}
