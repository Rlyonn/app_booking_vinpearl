import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class User{
  String? ho, ten, namSinh, sdt, email, anh;

  User({
    this.ho, this.ten, this.namSinh, this.sdt, required this.email, this.anh,
  });

  Map<String, dynamic> toJson() {
    return {
      'ho': this.ho,
      'ten': this.ten,
      'namSinh': this.namSinh,
      'sdt': this.sdt,
      'email': this.email,
      'anh': this.anh,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      ho: map['ho'] as String,
      ten: map['ten'] as String,
      namSinh: map['namSinh'] as String,
      sdt: map['sdt'] as String,
      email: map['email'] as String,
      anh: map['anh'] as String,
    );
  }
}

class UserSnapshot {
  User? user;
  DocumentReference? documentReference;

  UserSnapshot({
    required this.user,
    required this.documentReference,
  });

  factory UserSnapshot.fromSnapshot(DocumentSnapshot docSnapUser){
    return UserSnapshot(
      user: User.fromJson(docSnapUser.data() as Map<String, dynamic>),
      documentReference: docSnapUser.reference,
    );
  }

  
  static Stream<List<UserSnapshot>> listUser(){
    Stream<QuerySnapshot> streamUser = FirebaseFirestore.instance.collection("user").snapshots();
    Stream<List<DocumentSnapshot>> streamListUser = streamUser.map((queryInfo) => queryInfo.docs);
    return streamListUser.map((listDocSnap) => listDocSnap.map((docSnap) => UserSnapshot.fromSnapshot(docSnap)).toList());
  }

  static Stream<List<UserSnapshot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("user").snapshots();
    return streamQS.map((qs) => qs.docs.map((doc) => UserSnapshot.fromSnapshot(doc)).toList());
  }

}