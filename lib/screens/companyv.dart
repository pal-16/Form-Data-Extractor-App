import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terna_app/screens/settings.dart';
import 'package:terna_app/screens/voiceform.dart';
import '../screens/upload.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/voiceform.dart';

/*class Companyv extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Text("Flutter Create Checkbox Dynamically"),
        ),
        body: SafeArea(
          child : Center(
 
          child:CheckboxWidget(),
 
          )
        )
      ),
    );
  }
}
*/
class Companyv extends StatefulWidget {
  static const routeName = '/home';

  @override
  _CompanyvState createState() => new _CompanyvState();
}

class _CompanyvState extends State {
  Map<String, bool> numbers = {
    'Name': false,
    'Email': false,
    'Age': false,
    'Salary expecting': false,
    'Occupation': false,
    'Income': false,
    'Nationality': false,
  };
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

  var holder = [];
  saveform() async {
    numbers.forEach((key, value) {
      if (!holder.contains(key)) {
        if (value == true) {
          holder.add(key);
        }
      }
    });
    print(holder);
    print(holder.toList());
    print(holder.toSet());
    print(holder.toString());

    final String url = "http://1b77e76a.ngrok.io/voice";
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({'data': holder}),
    );
  }

  var getholder = [];
  getPreview() async {
    final res = await http.get("http://1b77e76a.ngrok.io/getvoice",
        headers: {"Accept": "aplication/json"});
    final jsonData = json.decode(res.body);
    getholder = jsonData['data'];
    print("=====");
    print(
        getholder); // @saif =======> get holder prints ['name','age','salary']
    // print(getholder[0]);
  }

  getNew() {
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "enter the field you want to add",
          style: TextStyle(fontFamily: 'Aleo', fontWeight: FontWeight.bold),
        ),
        content: TextFormField(controller: customController),
        actions: <Widget>[
          FlatButton(
            child: Text("Submit",
                style:
                    TextStyle(fontFamily: 'Aleo', fontWeight: FontWeight.bold)),
            onPressed: () {
              //   print("=========================================");
              // print(customController.text);
              if (customController.text != '')
                holder.add(customController.text);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _scaffoldKey = new GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyAppDrawer(),
      appBar: appBar(_scaffoldKey),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: numbers.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key),
                  value: numbers[key],
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      numbers[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          RaisedButton(
            child: Text(
              "save form ",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: saveform,
            color: Colors.white,
            textColor: Colors.black,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          ),
          RaisedButton(
            child: Text(
              "Add my own field ",
              style: TextStyle(fontSize: 12),
            ),
            onPressed: getNew,
            color: Colors.white,
            textColor: Colors.black,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          RaisedButton(
            child: Text(
              "Retrieve",
              style: TextStyle(fontSize: 12),
            ),
            onPressed: getPreview,
            color: Colors.white,
            textColor: Colors.black,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          RaisedButton(
            child: Text(
              "Generate voice form",
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VoiceHome(properties: getholder),
              ),
            ),
            color: Colors.white,
            textColor: Colors.black,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
        ],
      ),
    );
  }
}
