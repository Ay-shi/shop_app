import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  //const EditProduct({ Key? key }) : super(key: key);
  static const String routename = "/EditProduct";

  @override
  State<EditProduct> createState() => _EditProductState();
}

class ProductSample {
  String id = "";
  String title = "";
  double price = 0;
  String description = "";
  String imageUrl = "";
  bool isFavourite = false;
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imgFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var ps = ProductSample();
  Product? prod;
  bool _init = true;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _imgFocusNode.addListener(_updateImg);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      final id = ModalRoute.of(context)!.settings.arguments.toString();
      //print(id);
      if (id == "null") {
        //print("false");

        // _init = false;
        // return;
      }
      //ModalRoute.of(context)?.settings.arguments
      if (id != "null") {
        //print("hello");
        prod = Provider.of<Products>(context, listen: false).findProd(id);
        //print("h");
        ps.title = prod!.title;
        ps.price = prod!.price;
        ps.description = prod!.description;
        ps.id = prod!.id;
        ps.isFavourite = prod!.isFavourite;
        _imageUrlController.text = prod!.imageUrl;
      }
    }
    //print("h2");
    _init = false;
  }

  @override
  void dispose() {
    _imgFocusNode.removeListener(() {
      _updateImg;
    });
    _imageUrlController.dispose();

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _updateImg() {
    if (!_imgFocusNode.hasFocus) {
      if (!(_imageUrlController.text.startsWith("http") ||
          (_imageUrlController.text.startsWith("https")))) return;
      //     ||
      // (!(_imageUrlController.text.endsWith(".png") ||
      //     (_imageUrlController.text.endsWith(".jpeg")) ||
      //     _imageUrlController.text.endsWith(".jpg")))) return;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("hello..");
    Future<void> _saveForm() async {
      var isvalid = _form.currentState!.validate();
      if (isvalid == false) return;
      _form.currentState!.save();
      //print(ps.imageUrl);
      prod = Product(
          id: ps.id,
          title: ps.title,
          description: ps.description,
          imageUrl: ps.imageUrl,
          price: ps.price,
          isFavourite: ps.isFavourite);
      setState(() {
        _isLoading = true;
      });
      if (ps.id == "") {
        //print("hehe");
        try {
          await Provider.of<Products>(context, listen: false).addProduct(prod!);
        } catch (eror) {
          await showDialog<Null>(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text("an error occured"),
                  content: Text(eror.toString()),
                  actions: [
                    TextButton(
                        child: Text("close"),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        })
                  ],
                );
              });
        } finally {
          print("heyy");
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        }
        //print(Provider.of<Products>(context).items);
      } else {
        Provider.of<Products>(context, listen: false).upateProduct(prod!);
        Navigator.of(context).pop();
      }
      //print("hilo");
    }

    prod = Product(
        id: ps.id,
        title: ps.title,
        description: ps.description,
        imageUrl: ps.imageUrl,
        price: ps.price,
        isFavourite: ps.isFavourite);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
                return;
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: prod!.title,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(labelText: "Title"),
                          onSaved: (val) {
                            ps.title = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title not entered";
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFormField(
                          initialValue: prod!.price.toString(),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _priceFocusNode,
                          decoration: InputDecoration(labelText: "Price"),
                          keyboardType: TextInputType.number,
                          onSaved: (val) {
                            ps.price = double.parse(val!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) return "Enter a price";
                            if (double.tryParse(value) == null) {
                              return "Enter a valid input";
                            }
                            if (double.parse(value) <= 0)
                              return "Enter a velue greater then 0";

                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: prod!.description,
                          focusNode: _descriptionFocusNode,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(labelText: 'Description'),
                          onSaved: (val) {
                            ps.description = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) return "Enter a description";
                            if (value.length <= 10)
                              return "Enter a descprition with more than 10 characters";
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 70,
                              height: 70,
                              child: _imageUrlController.text.isEmpty
                                  ? Text("Url not entered")
                                  : FittedBox(
                                      child: Image.network(
                                          _imageUrlController.text),
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Image URL"),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                focusNode: _imgFocusNode,
                                onSaved: (val) {
                                  ps.imageUrl = val!;
                                },
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                  return;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) return "Enter th url";
                                  if (!(value.startsWith("http") ||
                                      (value.startsWith("https"))))
                                    return "Enter a valid URL";
                                  // if (!(value.endsWith(".png") ||
                                  //     (value.endsWith(".jpeg")) ||
                                  //     value.endsWith(".jpg")))
                                  //   return "Enter a valid URL";
                                  return null;
                                },
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
