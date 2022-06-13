import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/screens/drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  //const OrdersClass({ Key? key }) : super(key: key);
  static const String namedRoute = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (isInit) {
      try {
        setState(() {
          isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).fetchAndSet();
        setState(() {
          print("false");
          isLoading = false;
        });
      } catch (error) {
        print(error);
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("orders"),
      ),
      drawer: DrawerScreen(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (cntx, i) {
                return OrderItem(orders[i]);
              },
              itemCount: orders.length,
            ),
    );
  }
}
