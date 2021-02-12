import 'package:flutter/material.dart';

import 'billing_page.dart';

class CheckBillingPage extends StatefulWidget {
  CheckBillingPage({Key key}) : super(key: key);

  @override
  _CheckBillingPageState createState() {
    return _CheckBillingPageState();
  }
}

class _CheckBillingPageState extends State<CheckBillingPage> {
  bool _loading = false;
  TextEditingController meterNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,elevation: 0, title: Text("Check billing", style: TextStyle(color: Colors.black),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: meterNumberController,
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
            TextField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: phoneNumberController,
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
                  //prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter phone number'),
            ),
            SizedBox(height: 15,),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
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
                  //prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter email'),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                    child: RaisedButton(
                      onPressed: (){
                        meterNumberController;
                        phoneNumberController;
                        emailController;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillingPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text("Check", style: TextStyle(color: Colors.white, fontSize: 16),),
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
          ],),
      ),
    );
  }
}