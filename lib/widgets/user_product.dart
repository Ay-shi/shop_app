import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';

class UserProduct extends StatelessWidget {
  // const UserProduct({ Key? key }) : super(key: key);
  final title;
  final imageUrl;
  UserProduct({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pushNamed(EditProduct.routename);
                },
                icon: Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
