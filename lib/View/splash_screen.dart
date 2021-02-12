import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:power_house/View/create_account.dart';
import 'package:power_house/View/dashboard.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Firebase.initializeApp();
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => CreateAccountPage())));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => CreateAccountPage()));
            },
            child: Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/logo.png", width: 100,),
                SizedBox(height: 10,),
                Text("POWER HOUSE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),),
              ],
            )))
      ],),
    );
  }
}