import 'package:flutter/material.dart';
import 'package:power_house/View/complaint_success_page.dart';

class ComplaintsPage extends StatefulWidget {
  ComplaintsPage({Key key}) : super(key: key);

  @override
  _ComplaintsPageState createState() {
    return _ComplaintsPageState();
  }
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  bool _loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController meterNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController complaintsController = TextEditingController();
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
        backgroundColor: Colors.transparent,elevation: 0, title: Text("Complaints", style: TextStyle(color: Colors.black),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
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
                  //prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter your email'),
            ),
            SizedBox(height: 15,),/*
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      //labelStyle: textStyle,
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      hintText: 'Please select expense',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                  //isEmpty: _currentSelectedValue == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      //value: _currentSelectedValue,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          //_currentSelectedValue = newValue;
                          state.didChange(newValue);
                        });
                      },
                      style: Theme.of(context).textTheme.title,
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),*/
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
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
            TextField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: phoneNumberController,
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
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: complaintsController,
              maxLines: 5,
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
                  //prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter your complaints'),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                    child: RaisedButton(
                      onPressed: (){
                        !_loading;
                        emailController;
                        meterNumberController;
                        phoneNumberController;
                        complaintsController;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => ComplaintSuccessPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text("Send", style: TextStyle(color: Colors.white, fontSize: 16),),
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