import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);
  final showFav;
  ProductGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            //create: (_) =>
            value: products[i],
            child: ProductItem(),
            //   id: products[i].id,
            //   imageUrl: products[i].imageUrl,
            //   title: products[i].title,
            // ),
          );
        },
        itemCount: products.length);
  }
}
