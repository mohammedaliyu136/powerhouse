import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:power_house/View/buy_units.dart';
import 'package:power_house/View/check_billing.dart';
import 'package:power_house/View/complaints.dart';
import 'package:power_house/View/pay_bills.dart';
import 'package:power_house/View/register_meter.dart';
import 'package:power_house/View/transaction_history.dart';
import 'package:provider/provider.dart';

import 'billing_page.dart';
import 'login.dart';

import './../bloc/bloc.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  Bloc bloc;
  @override
  void initState() {
    PaystackPlugin.initialize(
        publicKey: "pk_live_7d59d69cc76bbd1ec61dfddadde5175ad8b9f78e");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bloc = Provider.of<Bloc>(context);
    print(bloc.getUserProfile);
    return Scaffold(
      appBar: AppBar(title: Text("Power House"),),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.electrical_services, size: 70, color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: Text(bloc.getUserProfile!=null?bloc.getUserProfile["name"]:"", style: TextStyle(fontSize: 16,  color: Colors.white,),),
                  ),
                  Text(bloc.mUserCredential.user.email, style: TextStyle(color: Colors.white,),),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard_rounded),
              title: Text('Dashboard', style: TextStyle(fontSize: 18),),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.backpack_sharp),
              title: Text('Buy units', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyUnitsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Pay bills', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BillingPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Transaction history', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionHistoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.warning_rounded),
              title: Text('Complaints', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Check billing', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckBillingPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_rounded),
              title: Text('Add Meter', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterMeterPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout', style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: ListView(children: [
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                child: Container(
                  height: 150,width: 160,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyUnitsPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Buy units", style: TextStyle(fontSize: 16,),),
                        ),
                        Icon(Icons.shopping_bag_sharp, size: 50, color: Colors.red,),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                )),
            SizedBox(width: 10,),
            Card(
                child: Container(
                  height: 150,width: 160,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BillingPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Pay bills", style: TextStyle(fontSize: 16),),
                        ),
                        Icon(Icons.payment, size: 50, color: Colors.red,),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                )),
        ],),
        SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Card(
              child: Container(
                height: 150,width: 160,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComplaintsPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Complaints", style: TextStyle(fontSize: 16),),
                      ),
                      Icon(Icons.warning_rounded, size: 50, color: Colors.red,),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              )),
          SizedBox(width: 10,),
            Card(
                child: Container(
                  height: 150,width: 160,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckBillingPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Check billing", style: TextStyle(fontSize: 16,),),
                        ),
                        Icon(Icons.receipt_long, size: 50, color: Colors.red,),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                )),
        ],),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(width: 10,),
            Card(
                child: Container(
                  height: 150,width: 180,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionHistoryPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Transaction history", style: TextStyle(fontSize: 16,),),
                        ),
                        Icon(Icons.history, size: 50, color: Colors.red,),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                )),
          ],),

      ],),
    );
  }
}