import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_item.dart';
import 'package:shop_app/providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({required this.id, required this.title, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final selectedProduct = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            selectedProduct.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: selectedProduct.id),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              selectedProduct.title,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                icon: Icon(
                  selectedProduct.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  selectedProduct.toggleFvourite();
                },
              ),
            ),
            trailing: Consumer<Cart>(
              builder: (context, value, child) => IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  value.add(selectedProduct.id, selectedProduct.title,
                      selectedProduct.price);
                },
              ),
            )),
      ),
    );
  }
}
