import 'package:flutter/material.dart';
import 'package:power_house/View/create_account.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() {
    return _ForgetPasswordPageState();
  }
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
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
        backgroundColor: Colors.transparent,elevation: 0,),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.black26,),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontFamily: "WorkSansLight"),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Enter email address'),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        child: RaisedButton(
                          onPressed: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text("Reset my password", style: TextStyle(color: Colors.white, fontSize: 16),),
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
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text("Login"),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Text("Create An Account"),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccountPage(),
                          ),
                        );
                      },
                    ),
                  ],),
              ],),
          ),
        ],
      ),
    );
  }
}