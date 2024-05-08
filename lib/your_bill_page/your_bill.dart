import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vinpearl_app/auth.dart';
import 'package:intl/intl.dart';
import 'package:vinpearl_app/your_bill_page/order_data.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late final User user;
  late List<OrderSnapshot> orders = [];

  @override
  void initState() {
    super.initState();
    user = Auth().currentUser!;
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await OrderSnapshot.listOrderByEmail(user.email!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 70),
          child: Text('Your Bill'),
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          Order order = orders[index].order!;
          return Container(
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Center(
                child: Text(
                  'Hóa đơn ${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...order.orders.map((orderItem) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${orderItem.tenDV}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Divider(),
                        Text('Quantity: ${orderItem.sl}'),
                        Divider(),
                        Text('Order date: ${DateFormat('dd/MM/yyyy  HH:mm:ss').format(orderItem.orderDate)}'),
                        Divider(thickness: 3),
                      ],
                    );
                  }).toList(),
                  Text("Total Price: ${order.orders[0].gia} VND", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent, fontSize: 16),),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
