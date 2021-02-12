import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:power_house/View/success_message_bill_payment.dart';
import 'package:power_house/bloc/bloc.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class BillingPage extends StatefulWidget {
  BillingPage({Key key}) : super(key: key);

  @override
  _BillingPageState createState() {
    return _BillingPageState();
  }
}

class _BillingPageState extends State<BillingPage> {
  Bloc bloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    String _cardNumber;
    String _cvv;
    int _expiryMonth = 0;
    int _expiryYear = 0;
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
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
        backgroundColor: Colors.transparent,elevation: 0, title: Text("Billing", style: TextStyle(color: Colors.black),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Account name", style: TextStyle(fontSize: 18),),
                Text(bloc.getUserProfile["name"], style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(height: 1,child: Container(color: Colors.black26,),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Meter number ", style: TextStyle(fontSize: 18),),
                Text(bloc.getUserProfile["meter_number"], style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(height: 1,child: Container(color: Colors.black26,),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Net arrears", style: TextStyle(fontSize: 18),),
                Text("0.0", style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(height: 1,child: Container(color: Colors.black26,),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Current changes", style: TextStyle(fontSize: 18),),
                Text("₦"+bloc.getAmount.toString(), style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(height: 1,child: Container(color: Colors.black26,),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("VAT", style: TextStyle(fontSize: 18),),
                Text("0.0", style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(height: 1,child: Container(color: Colors.black26,),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TOTAL", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text("₦"+bloc.getAmount.toString(), style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 30,),
            RaisedButton(
              onPressed: ()async{
                Charge charge = Charge()
                //..amount = amountController.text.toInt()*100 // In base currency
                  ..amount = bloc.getAmount*100 // In base currency
                  ..email = bloc.mUserCredential.user.email
                //..putCustomField('Restaurant', bloc.restaurantDocument["name"])
                  ..card = _getCardFromUI();

                String ref = _getReference();

                //charge.reference = _reference;
                charge.reference = ref;
                await PaystackPlugin.checkout(
                  context,
                  method: CheckoutMethod.card, //_method,
                  charge: charge,
                  fullscreen: false,
                  logo: MyLogo(),
                ).then((response){
                  //return response;
                  print("+++++++++++++++++++++");
                  print(response);
                  print(response.message);
                  //response.message=="Success" || response.message=="Transaction already succeeded"
                  if(response.status){
                    //bloc.postOrder("card", context, _reference);
                    print("#############");
                    print("#############");
                    print(response.status);
                    CollectionReference profile = FirebaseFirestore.instance.collection('transaction');
                    profile
                        .add({
                      'type': "Bill Payment", // John Doe
                      'account_name': bloc.getUserProfile["name"], // Stokes and Sons
                      'ref': ref, // 42
                      'date': "02-12-2021",
                      'amount': bloc.getAmount,
                      'uid': bloc.mUserCredential.user.uid // 42
                    })
                        .then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SuccessMessageBillsPayment(ref))))
                        .catchError((error) => print("Failed to add user: $error"));

                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text("Pay Now", style: TextStyle(color: Colors.white, fontSize: 16),),
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
class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Text(
        "Power House",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}