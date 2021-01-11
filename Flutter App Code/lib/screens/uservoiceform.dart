import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terna_app/screens/settings.dart';
import 'package:terna_app/screens/voiceform.dart';
import '../screens/voiceform.dart';
import '../widgets/app_drawer.dart';
import '../providers/model.dart';
import '../global.dart';

class UserVoiceForm extends StatefulWidget {
  static const routeName = '/userhome';

  @override
  _UserVoiceFormState createState() => new _UserVoiceFormState();
}

class _UserVoiceFormState extends State {
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
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            })
      ],
      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
    );
  }

  var holder;

  var getholder = [];

  Future<void> getPreview() async {
    final String url = urlInitial + "getformfields";
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({'formname': holder}),
    );

    final jsonData = json.decode(response.body);
    print(jsonData);
    getholder = jsonData['data'];
    print(getholder);
  }

  getNew() {
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Enter the form company name you want to fill?",
          style: TextStyle(fontFamily: 'Aleo', fontWeight: FontWeight.bold),
        ),
        content: TextFormField(controller: customController),
        actions: <Widget>[
          FlatButton(
            child: Text("Submit",
                style:
                    TextStyle(fontFamily: 'Aleo', fontWeight: FontWeight.bold)),
            onPressed: () {
              if (customController.text != '') holder = customController.text;
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
          SizedBox(
            height: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.search),
                        Text(
                          "Search for a company form",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    onPressed: getNew,
                    color: Color(0xff8f94fb),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.call_received),
                        Text(
                          " Retrieve",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onPressed: getPreview,
                    color: Color(0xff8f94fb),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.record_voice_over),
                        Text(
                          " Generate voice form",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await getPreview;
                      Navigator.of(context).pushNamed(VoiceHome.routeName,
                          arguments: {
                            "properties": getholder,
                            "formname": holder
                          });
                    },
                    color: Color(0xff8f94fb),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
