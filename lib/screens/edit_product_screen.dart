import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  //const EditProduct({ Key? key }) : super(key: key);
  static const String routename = "/EditProduct";

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imgFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _imgFocusNode.addListener(_updateImg);
    super.initState();
  }

  @override
  void dispose() {
    _imgFocusNode.removeListener(() {
      _updateImg;
    });
    _imageUrlController.dispose();
    _imageUrlController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _updateImg() {
    if (!_imgFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextFormField(
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    width: 70,
                    height: 70,
                    child: _imageUrlController.text.isEmpty
                        ? Text("Url not entered")
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.fill,
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      focusNode: _imgFocusNode,
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
