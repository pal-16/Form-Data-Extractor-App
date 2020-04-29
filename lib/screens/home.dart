//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:terna_app/screens/settings.dart';
import '../screens/upload.dart';
import '../widgets/app_drawer.dart';

// hex code for primary color - 8f94fb

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

  Widget appBar(scaffoldkey) {
    return AppBar(
      title: Text(
        "Terna App",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldkey.currentState.openDrawer();
        },
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            })
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _scaffoldKey = new GlobalKey();

    Widget homeCard(String imageUrl, String text, String action) {
      return Padding(
        padding: const EdgeInsets.all(13.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Upload(action))),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(imageUrl),
                  radius: 50,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget homePage() {
      return Padding(
        padding: const EdgeInsets.only(top: 90.0),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: [
            homeCard(
                "assets/images/1.png", "Scan Hardcopy Form", "registration"),
            homeCard("assets/images/2.png", "Generate Summary", "summarize"),
            homeCard("assets/images/3.png", "Evaluate your Resume", "resume"),
            homeCard(
                "assets/images/4.png", "Evaluate Feedback Forms", "feedback"),
          ],
        ),
      );
    }

    return Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/homebg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
            extendBodyBehindAppBar: true,
            key: _scaffoldKey,
            drawer: MyAppDrawer(),
            appBar: appBar(_scaffoldKey),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/homebg.png'),
                      fit: BoxFit.cover)),
              child: new Center(
                child: homePage(),
              ),
            )),
      ],
    );
  }
}

/*
new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'This screen appears after logging and signup',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Color.fromRGBO(143, 148, 251, 1),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Upload()));
                    },
                    child: Text(
                      'Upload',
                    ),
                  ),
                )
              ],
            ),
*/
