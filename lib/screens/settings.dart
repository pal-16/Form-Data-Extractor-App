import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 35.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Settings",
                      style: TextStyle(color: Colors.black, fontSize: 35.0),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Text("M"),
                    ),
                    Text(
                      "   Mohammed Mehdi",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
