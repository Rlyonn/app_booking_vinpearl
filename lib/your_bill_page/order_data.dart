import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  List<OrderItem> orders = [];
  String? email;

  Order({
    required this.orders,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'orders': this.orders.map((item) => item.toJson()).toList(),
      'email': this.email,
    };
  }

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      orders: (map['orders'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      email: map['email'] as String?,
    );
  }
}

class OrderItem {
  String tenDV;
  int sl;
  String gia;
  DateTime orderDate;

  OrderItem({
    required this.tenDV,
    required this.sl,
    required this.gia,
    required this.orderDate,
  });


  Map<String, dynamic> toJson() {
    return {
      'tenDV': this.tenDV,
      'sl': this.sl,
      'gia': this.gia,
      'orderDate': Timestamp.fromDate(this.orderDate),
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> map) {
    return OrderItem(
      tenDV: map['tenDV'] as String,
      sl: map['sl'] as int,
      gia: map['gia'] as String,
      orderDate: (map['orderDate'] as Timestamp).toDate(),
    );
  }
}

class OrderSnapshot {
  Order? order;
  DocumentReference? documentReference;

  OrderSnapshot({
    required this.order,
    required this.documentReference,
  });

  factory OrderSnapshot.fromSnapshot(DocumentSnapshot docSnapOrder) {
    return OrderSnapshot(
      order: Order.fromJson(docSnapOrder.data() as Map<String, dynamic>),
      documentReference: docSnapOrder.reference,
    );
  }

  static Future<void> addOrderToFirebase(Order order) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('Order').add({
      'email': order.email,
      'orders': order.orders.map((item) => item.toJson()).toList(),
    });
  }

  static Future<List<OrderSnapshot>> listOrderByEmail(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore.collection('Order')
          .where('email', isEqualTo: email)
          .get();

      List<OrderSnapshot> orders = [];
      for (DocumentSnapshot doc in querySnapshot.docs) {
        orders.add(OrderSnapshot.fromSnapshot(doc));
      }

      return orders;
    } catch (e) {
      print("Error fetching orders from Firestore: $e");
      return [];
    }
  }
}