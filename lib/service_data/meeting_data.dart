import 'package:cloud_firestore/cloud_firestore.dart';
class MeetingService {
  List<dynamic> anh;
  String chuU, cooktail, daTiec, dienTich, gia, lopHoc, maDV, moTa, nhaHat, tenDV;

  MeetingService({
    required this.anh,
    required this.chuU,
    required this.cooktail,
    required this.daTiec,
    required this.dienTich,
    required this.gia,
    required this.lopHoc,
    required this.maDV,
    required this.moTa,
    required this.nhaHat,
    required this.tenDV,
  });
  Map<String, dynamic> toJson() {
    return {
      'anh': anh,
      'chuU': chuU,
      'cooktail': cooktail,
      'daTiec': daTiec,
      'dienTich': dienTich,
      'gia': gia,
      'lopHoc': lopHoc,
      'maDV': maDV,
      'moTa': moTa,
      'nhaHat': nhaHat,
      'tenDV': tenDV,
    };
  }

  factory MeetingService.fromJson(Map<String, dynamic> map) {
    return MeetingService(
      anh: map['anh'] as List<dynamic>,
      chuU: map['chuU'] as String,
      cooktail: map['cooktail'] as String,
      daTiec: map['daTiec'] as String,
      dienTich: map['dienTich'] as String,
      gia: map['gia'] as String,
      lopHoc: map['lopHoc'] as String,
      maDV: map['maDV'] as String,
      moTa: map['moTa'] as String,
      nhaHat: map['nhaHat'] as String,
      tenDV: map['tenDV'] as String,
    );
  }
}

class MeetingServiceSnapshot {
  MeetingService meetingService;
  DocumentReference documentReference;

  MeetingServiceSnapshot({
    required this.meetingService,
    required this.documentReference,
  });

  String getTenDV() {
    return meetingService.tenDV;
  }
  String getAnh() {
    return meetingService.anh[0];
  }
  double getGia(){
    final price = double.parse(meetingService.gia);
    return price * getQuantity();
  }

  factory MeetingServiceSnapshot.fromSnapshot(DocumentSnapshot docSnapMeetingService) {
    return MeetingServiceSnapshot(
      meetingService: MeetingService.fromJson(docSnapMeetingService.data() as Map<String, dynamic>),
      documentReference: docSnapMeetingService.reference,
    );
  }

  static Stream<List<MeetingServiceSnapshot>> listMeetingService()
  {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("MeetingService").snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => MeetingServiceSnapshot.fromSnapshot(ds)).toList()
    );
  }

  int quantity = 1;

  // Method to get quantity
  int getQuantity() {
    return quantity;
  }

  // Method to increase quantity
  void increaseQuantity() {
    quantity++;
  }

  // Method to decrease quantity
  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}