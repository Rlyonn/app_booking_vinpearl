import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileData{
  String? ho, ten, email, namSinh, sdt, anh;

  ProfileData({
    required this.email,
    this.anh,
    this.ho,
    this.ten,
    this.namSinh,
    this.sdt
  });

  Map<String, dynamic> toJson() {
    return {
      'anh': this.anh,
      'ho': this.ho,
      'ten': this.ten,
      'email': this.email,
      'namSinh': this.namSinh,
      'sdt': this.sdt,
    };
  }

  factory ProfileData.fromJson(Map<String, dynamic> map) {
    return ProfileData(
      anh: map['anh'] as String,
      ho: map['ho'] as String,
      ten: map['ten'] as String,
      email: map['email'] as String,
      namSinh: map['namSinh'] as String,
      sdt: map['sdt'] as String,
    );
  }
}

class ProfileDataSnapshot{
  ProfileData? profileData;
  DocumentReference? documentReference;

  ProfileDataSnapshot({
    required this.profileData,
    required this.documentReference
  });

  factory ProfileDataSnapshot.fromSnapshot(DocumentSnapshot documentSnapshotProfile){
    return ProfileDataSnapshot(
      profileData: ProfileData.fromJson(documentSnapshotProfile.data() as Map<String, dynamic>),
      documentReference: documentSnapshotProfile.reference
    );
  }

  Future<void> updateUser(ProfileData profileData) async{
    return documentReference?.update(profileData.toJson());
  }

  static Future<void> addUser(ProfileData profileData, String uid) async{
    FirebaseFirestore.instance.collection("user").doc(uid).set(
      {
        'ho': profileData.ho,
        'ten': profileData.ten,
        'anh': profileData.anh,
        'namSinh': profileData.namSinh,
        'sdt': profileData.sdt,
        'email': profileData.email,
      }
    );
  }

  static Stream<List<ProfileDataSnapshot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("user").snapshots();
    return streamQS.map((qs) => qs.docs.map((doc) => ProfileDataSnapshot.fromSnapshot(doc)).toList());
  }

  static Stream<List<ProfileDataSnapshot>> listProfileData(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("user").snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map((querryInfo) => querryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => ProfileDataSnapshot.fromSnapshot(ds)).toList());
  }
}