import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/upload.dart';

import '../widgets/app_drawer.dart';

class Result extends StatefulWidget {
  static const routeName = '/result';

  @override
  _ResultState createState() => new _ResultState();
}

class _ResultState extends State<Result> {
  @override
  initState() {
    super.initState();
  }

  Widget appBar(scaffoldkey) {
    return AppBar(
      title: Text(
        "Terna App",
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldkey.currentState.openDrawer();
        },
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.settings), color: Colors.white, onPressed: () {})
      ],
      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _scaffoldKey = new GlobalKey();
    return Scaffold(
        key: _scaffoldKey,
        drawer: MyAppDrawer(),
        appBar: appBar(_scaffoldKey),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'This screen displays results got from api',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Color.fromRGBO(143, 148, 251, 1),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Upload()));
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
