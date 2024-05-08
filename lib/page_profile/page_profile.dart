import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vinpearl_app/page_profile/edit_page.dart';
import 'package:vinpearl_app/page_profile/profile_data.dart';

import 'profile_data.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key,}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileDataSnapshot? pro;
  TextEditingController txtHo = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  TextEditingController txtNamSinh = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProfileDataSnapshot>>(
      stream: ProfileDataSnapshot.getAll(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("P R O F I L E"),
            actions: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(),)),
                icon: Icon(Icons.settings, color: Colors.black54,),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: Image(image: AssetImage('assets/images/logoVinP.png'), height: 150, width: 200,)
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                    Text("Tai khoan: ${user!.email!}", style: TextStyle(fontSize: 18),),
                    SizedBox(height: 10,),
                    TextField(
                      controller: txtHo,
                      decoration: InputDecoration(
                        label: Text("Ho:"),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: txtTen,
                      decoration: InputDecoration(
                        label: Text("Ten:"),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: txtNamSinh,
                      decoration: InputDecoration(
                        label: Text("Nam Sinh:"),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: txtSdt,
                      decoration: InputDecoration(
                        label: Text("SDT:"),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  void initState() {
    //TODO: implement initSate
    super.initState();
    if(pro != null){
      txtHo.text = pro!.profileData?.ho??"";
      txtTen.text = pro!.profileData?.ten??"";
      txtNamSinh.text = pro!.profileData?.namSinh??"";
      txtSdt.text = pro!.profileData?.sdt??"";
    }
  }

  @override
  void dispose() {
    super.dispose();
    txtHo.dispose();
    txtTen.dispose();
    txtNamSinh.dispose();
    txtSdt.dispose();
  }
}

