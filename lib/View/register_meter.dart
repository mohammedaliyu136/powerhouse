import 'package:flutter/material.dart';
import 'package:power_house/View/dashboard.dart';

class RegisterMeterPage extends StatefulWidget {
  RegisterMeterPage({Key key}) : super(key: key);

  @override
  _RegisterMeterPageState createState() {
    return _RegisterMeterPageState();
  }
}

class _RegisterMeterPageState extends State<RegisterMeterPage> {
  var meterType;
  TextEditingController meterNumberController = TextEditingController();
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
      appBar: AppBar(title: Text("Meter Information"),),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Row(
              children: [
                Expanded(
                    child: RaisedButton(
                      onPressed: (){},
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 16),),
                      ),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.red)
                      ),
                    )
                ),
                SizedBox(width: 20,),
                Expanded(
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => DashBoard()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16),),
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
          ),
        ],),
      ),
    );
  }
}