import 'package:cloud_firestore/cloud_firestore.dart';
class RestaurantService {
  List<dynamic> anh;
  String diaChi, gia, maDV, moTa, openingTime, sdt, tenDV, xepLoai;

  RestaurantService({
    required this.anh,
    required this.diaChi,
    required this.gia,
    required this.maDV,
    required this.moTa,
    required this.openingTime,
    required this.sdt,
    required this.tenDV,
    required this.xepLoai,
  });

  Map<String, dynamic> toJson() {
    return {
      'anh': anh,
      'diaChi': diaChi,
      'gia': gia,
      'maDV': maDV,
      'moTa': moTa,
      'openingTime': openingTime,
      'sdt': sdt,
      'tenDV': tenDV,
      'xepLoai': xepLoai,
    };
  }

  factory RestaurantService.fromJson(Map<String, dynamic> map) {
    return RestaurantService(
      anh:map['anh'] as List<dynamic>,
      diaChi: map['diaChi'] as String,
      gia: map['gia'] as String,
      maDV: map['maDV'] as String,
      moTa: map['moTa'] as String,
      openingTime: map['openingTime'] as String,
      sdt: map['sdt'] as String,
      tenDV: map['tenDV'] as String,
      xepLoai: map['xepLoai'] as String,
    );
  }
}

class RestaurantServiceSnapshot {
  RestaurantService restaurantService;
  DocumentReference documentReference;

  RestaurantServiceSnapshot({
    required this.restaurantService,
    required this.documentReference,
  });

  String getTenDV() {
    return restaurantService.tenDV;
  }
  String getAnh() {
    return restaurantService.anh[0];
  }
  double getGia(){
    final price = double.parse(restaurantService.gia);
    return price * getQuantity();
  }

  factory RestaurantServiceSnapshot.fromSnapshot(DocumentSnapshot docSnapGolfService) {
    return RestaurantServiceSnapshot(
      restaurantService: RestaurantService.fromJson(docSnapGolfService.data() as Map<String, dynamic>),
      documentReference: docSnapGolfService.reference,
    );
  }

  static Stream<List<RestaurantServiceSnapshot>> listRestaurantService()
  {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("RestaurantService")
        .snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => RestaurantServiceSnapshot.fromSnapshot(ds)).toList()
    );
  }

  int quantity = 1;
  int getQuantity() {
    return quantity;
  }
  void increaseQuantity() {
    quantity++;
  }
  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}