import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_house/View/create_account.dart';
import 'package:power_house/View/forget_password.dart';
import 'package:power_house/bloc/bloc.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  Bloc bloc;
  bool _loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void login()async{
    setState(() {
      _loading=true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      print(userCredential);
      bloc.setUserCredentail(userCredential);
      //
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bloc = Provider.of<Bloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  //borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(color: Colors.black12),
                  //borderSide: const BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  //borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(
                      color: Colors.red, width: 1.7),
                ),
                prefixIcon: Icon(Icons.email_outlined, color: Colors.black26,),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                hintStyle: TextStyle(
                    color: Colors.grey, fontFamily: "WorkSansLight"),
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Enter email address'),
          ),
          SizedBox(height: 15,),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  //borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(color: Colors.black12),
                  //borderSide: const BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  //borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(
                      color: Colors.red, width: 1.7),
                ),
                prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black26,),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                hintStyle: TextStyle(
                    color: Colors.grey, fontFamily: "WorkSansLight"),
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Enter password'),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Expanded(
                  child: RaisedButton(
                    onPressed: (){
                      login();
                      //Navigator.of(context).pushReplacement(MaterialPageRoute(
                       //   builder: (BuildContext context) => DashBoard()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.red)
                    ),
                  )
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            GestureDetector(
                child: Text("Create An Account"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccountPage(),
                    ),
                  );
                },
            ),
            GestureDetector(
                child: Text("Forgot password"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordPage(),
                    ),
                  );
                },
            )
          ],),
        ],),
      ),
    );
  }
}