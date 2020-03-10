import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/upload.dart';

import '../widgets/app_drawer.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  initState() {
    super.initState();
  }

  final appBar = AppBar(
    title: Text(
      "Terna_App",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color.fromRGBO(143, 148, 251, 1),
  );

  


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        drawer: AppDrawer(appBar),
        appBar: appBar,
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('This screen appears after logging and signup',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Upload()));
        },
        child: Text('Upload your form'),
                ),
              )
            ],
          ),
        )
        );
  }

}