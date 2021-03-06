import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_item.dart';
import 'package:shop_app/screens/cart_screem.dart';
import 'package:shop_app/screens/drawer.dart';
import 'package:shop_app/widgets/product_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
// import '../models/product.dart';
// import '../widgets/product_item.dart';

enum filterOptions { favouritesOnly, showAll }

class ProductOverview extends StatefulWidget {
  //const ProductOverview({ Key? key }) : super(key: key);
  static const routename = "/productOverview";

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool showFav = false;
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        print("hey");
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

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
      drawer: DrawerScreen(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(showFav),
    );
  }
}
