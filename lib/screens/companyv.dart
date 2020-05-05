import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terna_app/screens/settings.dart';
import 'package:terna_app/screens/voiceform.dart';
import '../screens/voiceform.dart';
import '../widgets/app_drawer.dart';
import '../providers/model.dart';

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

  var holder = [];

  Future<void> saveForm() async {
    print("hello");
    numbers.forEach((key, value) {
      if (!holder.contains(key)) {
        if (value == true) {
          holder.add(key);
        }
      }
    });
    print(holder);

    final String url = "http://2ec43766.ngrok.io/createvoicefields";
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({'data': holder, 'email': User.email}),
    );
  }

  var getholder = [];

  getPreview() async {
    final String url = "http://2ec43766.ngrok.io/getvoicefields";
    print(User.email);
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({'email': User.email}),
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
                        Icon(Icons.save),
                        Text(
                          " Save Form",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    onPressed: saveForm,
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
                        Icon(Icons.add),
                        Text(
                          " Add my own field ",
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
                          style: TextStyle(fontSize: 15),
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
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    onPressed: () {
                      print(holder);
                      Navigator.of(context).pushNamed(VoiceHome.routeName,
                          arguments: {"properties": getholder});
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
