import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WidgetConnectFirebase extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext context)? builder;
  const WidgetConnectFirebase({Key? key, required this.builder, required this.connectingMessage, required this.errorMessage}) : super(key: key);

  @override
  State<WidgetConnectFirebase> createState() => _WidgetConnectFirebaseState();
}

class _WidgetConnectFirebaseState extends State<WidgetConnectFirebase> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi){
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(widget.connectingMessage!,
            style: TextStyle(fontSize: 18,),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    }else{
      return widget.builder!(context);
    }
  }

  @override
  void initState(){
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase() async{
    try{
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    }catch(e){
      setState(() {
        loi = true;
      });
    }
  }
}
