import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_house/bloc/bloc.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatefulWidget {
  TransactionHistoryPage({Key key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() {
    return _TransactionHistoryPageState();
  }
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  Bloc bloc;
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
    bloc = Provider.of<Bloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,elevation: 0, title: Text("Transaction history", style: TextStyle(color: Colors.black),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("transaction").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data.docs[index];
                if(bloc.mUserCredential.user.uid==data["uid"]){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(data['type']),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(data['date']),
                          Text("PrePaid"),
                        ],
                      ),
                      subtitle: Text("Transaction ref: "+data['ref'].split("_")[1]),
                      onTap: (){},
                    ),
                    SizedBox(height: 1,child: Container(color:Colors.grey),)
                  ],
                );}else{
                  return Container();
                }
              },
            );
          },
        ),

        ),
    );
  }
}