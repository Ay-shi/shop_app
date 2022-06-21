import 'package:flutter/material.dart';
import 'package:shop_app/models/HttpException.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final authToken;
  final userId;

  Products(this._items, this.authToken, this.userId);
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ];
  bool showFavouritesOnly = false;

  // void setShowFavourite() {
  //   showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void setShowAll() {
  //   showFavouritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get items {
    // if (showFavouritesOnly)
    //   return [...(_items.where((element) => element.isFavourite))];
    return [..._items];
  }

  List<Product> get favouriteItems {
    return [...(_items.where((element) => element.isFavourite))];
  }

  Product findProd(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.https(
        "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/proucts.json",
        {"auth": "$authToken"});
    try {
      final response = await http.get(url);
      print(jsonDecode(response.body));
      final loadedData = json.decode(response.body) as Map<String, dynamic>;

      List<Product> _loadedProducts = [];
      url = Uri.https(
          "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
          "/favourites/$userId.json",
          {"auth": "$authToken"});
      var res = await http.get(url);
      final favouritestatus = json.decode(res.body);
      loadedData.forEach((productId, product) {
        _loadedProducts.add(Product(
            id: productId,
            title: product['title'],
            description: product['description'],
            imageUrl: product['imageUrl'],
            price: product['price'].toDouble(),
            isFavourite: favouritestatus == null
                ? false
                : favouritestatus['$productId'] ?? false));
        print(_loadedProducts);
      });
      _items = _loadedProducts;
      notifyListeners();
    } catch (error) {
      print("error");
      throw error;
    }
  }

  Future<void> addProduct(Product prod) async {
    final url = Uri.https(
        "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/proucts.json",
        {"auth": "$authToken"});
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': prod.title,
            'id': prod.id,
            'price': prod.price,
            'imageUrl': prod.imageUrl,
            'description': prod.description,
            "userId": userId
            // 'isFavourite': prod.isFavourite
          }));
      // .then((response) {
      Product p = Product(
          id: json.decode(response.body)['name'].toString(),
          title: prod.title,
          description: prod.description,
          imageUrl: prod.imageUrl,
          price: prod.price);
      _items.add(p);
      notifyListeners();
      // }).catchError((error) {
      //   print(error.toString() + "..");
      //   throw error;
      //   // return error;
      // });
    } catch (error) {
      throw error;
      //return error;
    }
  }

  Future<void> upateProduct(Product prod) async {
    final prodIndex = _items.indexWhere((element) => prod.id == element.id);
    final url = Uri.https(
        "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/proucts/${prod.id}.json",
        {"auth": "$authToken"});
    try {
      await http.patch(url,
          body: jsonEncode({
            "title": prod.title,
            "description": prod.description,
            "price": prod.price,
            "imageUrl": prod.imageUrl
          }));
      _items[prodIndex] = prod;
      // Product(
      //     id: prod.id,
      //     title: prod.title,
      //     description: prod.description,
      //     isFavourite: prod.isFavourite,
      //     price: prod.price,
      //     imageUrl: prod.imageUrl);
      notifyListeners();
    } catch (error) {
      print("error");
      throw error;
    }
  }

  Future<void> deleteProd(String prodId) async {
    final deletedIndex = _items.indexWhere((element) => element.id == prodId);
    Product? deletedProduct = _items[deletedIndex];
    _items.removeWhere((element) => element.id == prodId);
    notifyListeners();
    final url = Uri.https(
        "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/proucts/$prodId.json",
        {"auth": "$authToken"});
    try {
      final response = await http.delete(url);
    } catch (_) {
      print("error while deleting");
      _items.insert(deletedIndex, deletedProduct!);
      notifyListeners();

      throw HttpException("an error occured while deleting");
    }

    // if (response.statusCode >= 400) {
    //   print("error while deleting");
    //   _items.insert(deletedIndex, deletedProduct!);
    //   notifyListeners();

    //   throw HttpException("an error occured while deleting");
    // }
    deletedProduct = null;
  }
}
