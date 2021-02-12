import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:power_house/View/success_page.dart';
import 'package:power_house/bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class BuyUnitsPage extends StatefulWidget {
  BuyUnitsPage({Key key}) : super(key: key);

  @override
  _BuyUnitsPageState createState() {
    return _BuyUnitsPageState();
  }
}

class _BuyUnitsPageState extends State<BuyUnitsPage> {
  Bloc bloc;
  String pin_unit = "";
  bool _loading = false;
  bool _error = false;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
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
        backgroundColor: Colors.transparent,elevation: 0, title: Text("Buy units", style: TextStyle(color: Colors.black),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _error?Text("Please check your input", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),):Container(),
            _error?SizedBox(height: 10,):Container(),
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
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: amountController,
              decoration: InputDecoration(
                //prefixText: "₦",
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
                  hintText: 'Enter Amount'),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                    child: RaisedButton(
                      onPressed: () async {
                        phoneNumberController;
                        amountController;

                        if(phoneNumberController.text.isNotEmpty){
                          try {
                            var amt = int.parse(amountController.text)*100;
                            var rng = new Random();
                            var l = new List.generate(12, (_) => rng.nextInt(9));
                            print(l.join(""));
                            String ppin_unit = l.join("");
                            String ref = _getReference();

                            Charge charge = Charge()
                            //..amount = amountController.text.toInt()*100 // In base currency
                              ..amount = amt // In base currency
                              ..email = bloc.mUserCredential.user.email
                            //..putCustomField('Restaurant', bloc.restaurantDocument["name"])
                              ..card = _getCardFromUI();

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
                                  'type': "Units purchased", // John Doe
                                  'phonenumber': phoneNumberController.text, // Stokes and Sons
                                  'ref': ref, // 42
                                  'date': "12-12-2021",
                                  'units': amountController.text,
                                  'uid': bloc.mUserCredential.user.uid // 42
                                })
                                    .then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) => successPage(ppin_unit, ref))))
                                    .catchError((error) => print("Failed to add user: $error"));

                              }
                            });
                          }
                          catch(e) {
                            setState(() {
                              _error=true;
                            });
                          }
                        }else{
                          setState(() {
                            _error=true;
                          });
                        }
                        /*
                        */
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text("Buy now", style: TextStyle(color: Colors.white, fontSize: 16),),
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