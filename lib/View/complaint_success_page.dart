import 'package:flutter/material.dart';
import 'package:power_house/View/dashboard.dart';

class ComplaintSuccessPage extends StatelessWidget {
  ComplaintSuccessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.check_circle_outline, size: 80, color: Colors.red,)),
          SizedBox(height: 20,),
          Text("Complaint sent!", style: TextStyle(fontSize: 18),),
          SizedBox(height: 10,),
          Center(child: Text("You will be contacted as soon as possible.", style: TextStyle(fontSize: 18, color: Colors.grey),)),
          SizedBox(height: 10,),
          Center(child: Text("Thank you.", style: TextStyle(fontSize: 18, color: Colors.grey),)),
          SizedBox(height: 30,),
          RaisedButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => DashBoard()));
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text("Go back to Dashboard", style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)
            ),
          ),
          SizedBox(height: 30,),
        ],),
    );
  }
}
