import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bloc with ChangeNotifier {
  UserCredential mUserCredential;
  var mUserProfile;
  int _count = 0;
  var mAmount = 0;

  int get count => _count;

  void setUserCredentail(userCredential){
    mUserCredential = userCredential;
    notifyListeners();
  }
  UserCredential get getUserCredentail => mUserCredential;
  void setUserProfile(userProfile){
    mUserProfile = userProfile;
    notifyListeners();
  }
  get getUserProfile => mUserProfile;

  void setAmount(amount){
    mAmount = amount;
    notifyListeners();
  }
  get getAmount => mAmount;


}