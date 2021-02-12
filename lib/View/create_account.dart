import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:power_house/View/dashboard.dart';
import 'package:power_house/View/forget_password.dart';
import 'package:power_house/View/login.dart';
import 'package:power_house/View/register_meter.dart';
import 'package:provider/provider.dart';
import './../bloc/bloc.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() {
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccountPage> {
  bool _loading = false;
  Bloc bloc;
  var meterType;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController meterNumberController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();
  var mContext;
  @override
  void initState(){
    Firebase.initializeApp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
/*
  void _validateLoginInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      _sheetController.setState(() {
        _loading = true;
      });
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed('/home');
      } catch (error) {
        switch (error.code) {
          case "ERROR_USER_NOT_FOUND":
            {
              _sheetController.setState(() {
                errorMsg =
                "There is no user with such entries. Please try again.";

                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          case "ERROR_WRONG_PASSWORD":
            {
              _sheetController.setState(() {
                errorMsg = "Password doesn\'t match your email.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              _sheetController.setState(() {
                errorMsg = "";
              });
            }
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }


  void _validateRegisterInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      setState(() {
        _loading = true;
      });
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _email, password: _password);
        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _displayName;
        user.updateProfile(userUpdateInfo).then((onValue) {
          Navigator.of(context).pushReplacementNamed('/home');
          Firestore.instance.collection('users').document().setData(
              {'email': _email, 'displayName': _displayName}).then((onValue) {
            _sheetController.setState(() {
              _loading = false;
            });
          });
        });
      } catch (error) {
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            {
              _sheetController.setState(() {
                errorMsg = "This email is already in use.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          case "ERROR_WEAK_PASSWORD":
            {
              _sheetController.setState(() {
                errorMsg = "The password must be 6 characters long or more.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              _sheetController.setState(() {
                errorMsg = "";
              });
            }
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

 */
  CollectionReference profile = FirebaseFirestore.instance.collection('profile');

  Future<void> addProfile(uid) {
    // Call the user's CollectionReference to add a new user
    bloc.setAmount(4000);

    return profile
        .add({
      'name': nameController.text, // John Doe
      'phonenumber': phoneNumberController.text, // Stokes and Sons
      'email': emailController.text, // 42
      'meter_type': meterType,
      'meter_number': meterNumberController.text,
      'uid': uid // 42
    })
        .then((value) => bloc.setUserProfile({
      'name': nameController.text, // John Doe
      'phonenumber': phoneNumberController.text, // Stokes and Sons
      'email': emailController.text, // 42
      'meter_type': meterType,
      'meter_number': meterNumberController.text,
      'uid': uid // 42
    }))
        .catchError((error) => print("Failed to add user: $error"));
  }
  void registerUser()async{
    setState(() {
      _loading=true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      bloc.setUserCredentail(userCredential);
      print(userCredential.user.email);
      print(userCredential.user.uid);
      addProfile(userCredential.user.uid);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => DashBoard()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _loading=false;
    });
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    mContext=context;
    bloc = Provider.of<Bloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create Account To Getting Started", style: TextStyle(fontSize: 30),),
            SizedBox(height: 15,),
            TextField(
              keyboardType: TextInputType.name,
              controller: nameController,
              textInputAction: TextInputAction.next,
              enabled: !_loading,
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
                  prefixIcon: Icon(Icons.person, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter your name'),
            ),
            SizedBox(height: 15,),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              textInputAction: TextInputAction.next,
              enabled: !_loading,
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
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              textInputAction: TextInputAction.next,
              enabled: !_loading,
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
                  prefixIcon: Icon(Icons.phone, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter your phone number'),
            ),
            SizedBox(height: 15,),
            TextField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              enabled: !_loading,
              obscureText: true,
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
            SizedBox(height: 7,),/*
            TextField(
              keyboardType: TextInputType.text,
              controller: passwordConfirmController,
              enabled: !_loading,
              obscureText: true,
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
                  hintText: 'Confirm password'),
            ),*/
            Row(
              children: [
                SizedBox(width: 0,),
                Text("Meter type",style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButton<String>(
                    items: [
                      DropdownMenuItem<String>(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.electrical_services),
                            SizedBox(width: 10,),
                            Text('PrePaid'),
                          ],
                        ),
                        value: 'PrePaid',
                      ),
                      DropdownMenuItem<String>(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.electrical_services),
                            SizedBox(width: 10,),
                            Text('PostPaid'),
                          ],
                        ),
                        value: 'PostPaid',
                      ),
                    ],
                    isExpanded: false,
                    onChanged: (String value) {
                      setState(() {
                        meterType = value;
                      });
                    },
                    hint: Text('Select Meter'),
                    value: meterType,
                    underline: Container(
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.transparent))
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    iconEnabledColor: Colors.pink,
                    //        iconDisabledColor: Colors.grey,
                    iconSize: 30,
                  ),
                ),
              ],
            ),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: meterNumberController,
              enabled: !_loading,
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
                  //prefixIcon: Icon(Icons.email_outlined, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter your meter number'),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                    child: RaisedButton(
                      onPressed: ()async{
                        if(passwordController.text==passwordConfirmController.text){
                          print("password thesame");
                        }else{
                          print("password not thesame");
                        }
                        print(nameController.text);
                        print(emailController.text);
                        print(phoneNumberController.text);
                        print(passwordController.text);
                        ///await Firebase.initializeApp();
                        registerUser();

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(_loading?"Creating...":"Create account", style: TextStyle(color: Colors.white, fontSize: 16),),
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
                  child: Text("Forgot password"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage(),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: Text("Have An Account?\nLogin"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                )
              ],),
          ],),
      ),
    );;
  }
}