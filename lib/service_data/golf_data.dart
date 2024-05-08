import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
class GolfService {
  List<dynamic> anh;
  String diaChi, email, gia, maDV, moTa, sdt, tenDV, xepLoai;

  GolfService({
    required this.anh,
    required this.diaChi,
    required this.email,
    required this.gia,
    required this.maDV,
    required this.moTa,
    required this.sdt,
    required this.tenDV,
    required this.xepLoai,
  });
  Map<String, dynamic> toJson() {
    return {
      'anh': anh,
      'diaChi': diaChi,
      'email': email,
      'gia': gia,
      'maDV': maDV,
      'moTa': moTa,
      'sdt': sdt,
      'tenDV': tenDV,
      'xepLoai': xepLoai,
    };
  }

  factory GolfService.fromJson(Map<String, dynamic> map) {
    return GolfService(
      anh: map['anh'] as List<dynamic>,
      diaChi: map['diaChi'] as String,
      email: map['email'] as String,
      gia: map['gia'] as String,
      maDV: map['maDV'] as String,
      moTa: map['moTa'] as String,
      sdt: map['sdt'] as String,
      tenDV: map['tenDV'] as String,
      xepLoai: map['xepLoai'] as String,
    );
  }
}

class GolfServiceSnapshot {
  GolfService golfService;
  DocumentReference documentReference;

  GolfServiceSnapshot({
    required this.golfService,
    required this.documentReference,
  });

  String getTenDV() {
    return golfService.tenDV;
  }
  String getAnh() {
    return golfService.anh[0];
  }
  double getGia(){
    final price = double.parse(golfService.gia);
    return price * getQuantity();
  }

  //lấy số lượng
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

  factory GolfServiceSnapshot.fromSnapshot(DocumentSnapshot docSnapGolfService) {
    return GolfServiceSnapshot(
      golfService: GolfService.fromJson(docSnapGolfService.data() as Map<String, dynamic>),
      documentReference: docSnapGolfService.reference,
    );
  }

  static Stream<List<GolfServiceSnapshot>> listGolfService()
  {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("GolfService")
        .snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => GolfServiceSnapshot.fromSnapshot(ds)).toList()
    );
  }


}