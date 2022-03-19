import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/drawer.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/user_product.dart';

// AppBar appbar(){
//   return AppBar(
//     title: Text("My Products"),
//     actions: [
//         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
//     ],
//   );
// }

class UserProdutsScreen extends StatelessWidget {
  // const ManageUserProduts({ Key? key }) : super(key: key);
  static const String routename = '/userProductsScreen';
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text("My Products"),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProduct.routename);
            },
            icon: Icon(Icons.add)),
      ],
    );
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: appbar,
      body: Container(
        height:
            MediaQuery.of(context).size.height - appbar.preferredSize.height,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return UserProduct(
              title: productData.items[i].title,
              imageUrl: productData.items[i].imageUrl,
            );
          },
          itemCount: productData.items.length,
        ),
      ),
      drawer: DrawerScreen(),
    );
  }
}
