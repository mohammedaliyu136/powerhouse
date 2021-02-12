import 'package:flutter/material.dart';
import 'package:power_house/View/dashboard.dart';
import 'package:power_house/bloc/bloc.dart';
import 'package:provider/provider.dart';

class SuccessMessageBillsPayment extends StatelessWidget {
  String ref;
  SuccessMessageBillsPayment(this.ref);
  Bloc bloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bloc = Provider.of<Bloc>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Icon(Icons.check_circle_outline, size: 80, color: Colors.red,)),
            SizedBox(height: 20,),
            Text("Payment Successful", style: TextStyle(fontSize: 18),),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Meter number ", style: TextStyle(fontSize: 18),),
                Text(bloc.getUserProfile["meter_number"].toString(), style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount ", style: TextStyle(fontSize: 18),),
                Text("₦"+bloc.getAmount.toString(), style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transaction id ", style: TextStyle(fontSize: 18),),
                Text(ref.split("_")[1], style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 20,),
            Text("Thank you for paying your bills", style: TextStyle(fontSize: 18),),
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
      ),
    );
  }
}
