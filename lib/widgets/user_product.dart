import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';

class UserProduct extends StatelessWidget {
  // const UserProduct({ Key? key }) : super(key: key);
  Function deleteHandler;
  final productid;
  final title;
  final imageUrl;
  UserProduct(
      {required this.title,
      required this.imageUrl,
      required this.productid,
      required this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProduct.routename, arguments: productid);
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  try {
                    deleteHandler(productid);
                  } catch (error) {
                    print("object");
                    scaffold.showSnackBar(SnackBar(
                        content: Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                    )));
                  }
                },
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
