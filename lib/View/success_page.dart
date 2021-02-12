import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_house/View/dashboard.dart';

class successPage extends StatelessWidget {
  String ppin_unit;
  String ref;
  successPage(this.ppin_unit, this.ref);

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
        Text("Payment Successful", style: TextStyle(fontSize: 18),),
        SizedBox(height: 10,),
        Text("Your prepaid PIN is", style: TextStyle(fontSize: 18),),
        Text(ppin_unit, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text("Transaction id: "+ref.split("_")[1], style: TextStyle(fontSize: 18),),
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
        )
      ],),
    );
  }
}
