import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinpearl_app/auth.dart';
import 'package:vinpearl_app/page_home/home_screen.dart';
import 'package:vinpearl_app/page_profile/profile_data.dart';

class LogInRegisterPage extends StatefulWidget {
  const LogInRegisterPage({Key? key}) : super(key: key);

  @override
  State<LogInRegisterPage> createState() => _LogInRegisterPageState();
}

class _LogInRegisterPageState extends State<LogInRegisterPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userId;
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e){
      setState(() {
        if (e.code == 'Không tồn tại tài khoản') {
          print('Không tồn tại tài khoản');
        } else if (e.code == 'Sai mật khẩu') {
          print('Sai mật khẩu');
        }
        errorMessage = e.code;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
      if(_controllerPassword.text == _controllerConfirmPassword.text){
        await Auth().createUserWithEmailAndPassword(
            email: _controllerEmail.text.trim(),
            password: _controllerPassword.text.trim(),
        );
        userId = _firebaseAuth.currentUser!.uid;
        ProfileDataSnapshot.addUser(new ProfileData(
          email: _controllerEmail.text,
          anh: "",
          namSinh: "",
          ho: "",
          sdt: "",
          ten: "",
        ), userId!);
      } else{
        errorMessage = 'Xác nhận mật khẩu không đúng';
      }
    } on FirebaseAuthException catch (e){
      setState(() {
        if (e.code == 'Mật khẩu quá yếu') {
          print('Mật khẩu quá yếu');
        } else if (e.code == 'Tài khoản emal đã tồn tại') {
          print('Tài khoản emal đã tồn tại');
        }
        errorMessage = e.code;
      }
      );
    }
  }

  void addUser(String name, String email) {
    _firestore.collection('users').add({
      'name': name,
      'email': email,
    }).then((value) {
      print('User added successfully');
    }).catchError((error) {
      print('Failed to add user: $error');
    });
  }

  void getUsers() {
    _firestore.collection('users').get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print('Name: ${doc['name']}, Email: ${doc['email']}');
      });
    }).catchError((error) {
      print('Failed to get users: $error');
    });
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _passwordField(
    String title,
    TextEditingController controller,
      ){
    return TextField(
      controller: _controllerPassword,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: 'Mật khẩu / Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _confirmPassword(){
    return Container(
      child: TextField(
        controller: _controllerConfirmPassword,
        obscureText: true,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Xác nhận mật khẩu / Confirm Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage',style: TextStyle(color: Colors.red),);
  }
  
  Widget _submitButton(){
    return Container(
      height: 60,
      width: 300,
      child: ElevatedButton(
        onPressed:
          () {
            setState(() {
              isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();
            });
          },
        child: Text(isLogin ? 'Đăng nhập' : 'Đăng ký', style: TextStyle(fontSize: 18),),
      ),
    );
  }

  Widget _forgotPassword(){
    return Container(
      child:Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => null,
            child: Text(
              'Quên mật khẩu ?',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      )
    );
  }

  Widget _loginBanner(){
    return Container(
      child: Text(isLogin ? "Đăng nhập / Sign In" : 'Đăng ký / Sign Up',
        style: TextStyle(color: Colors.black, fontSize: 18),
      )
    );
  }

  Widget _loginOrRegisterButton(){
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register Now' : 'Login Now' , style: TextStyle(color: Colors.blue),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/logoVinP.png'), height: 200, width: 300,),
                ],
              ),
              SizedBox(height: 30,),
              _loginBanner(),
              SizedBox(height: 10,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //TextField đăng nhập
                        _entryField('Email', _controllerEmail),
                        SizedBox(height: 10,),
                        //Đăng Ký
                        _passwordField('Mật khẩu', _controllerPassword),
                        SizedBox(height: 10,),
                        Container(
                          child: Column(
                            children: [
                              if(!isLogin)
                                _confirmPassword(),
                            ],
                          ),
                        ),
                        //báo khi không đăng nhập thành công
                        _forgotPassword(),
                        _errorMessage(),
                        SizedBox(height: 10,),
                        _submitButton(),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Text('Dont have an account ?'),
                            _loginOrRegisterButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
