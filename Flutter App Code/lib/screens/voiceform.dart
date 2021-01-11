import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/model.dart';
import '../global.dart';

class VoiceHome extends StatefulWidget {
  static List<LocaleName> localeNames = [];
  static const String routeName = '/voice-home';

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  final SpeechToText speech = SpeechToText();

  List<dynamic> properties;
  String formname;
  // Do not change any list definitions from List<...> ... = [] to List<...> ... = new List
  var details = new Map();
  List<TextEditingController> controllers = [];

  List<String> result = [];

  List<String> temp = [];
  List<String> finalresult = [];
  List<double> level = [];

  List<String> lastError = [];

  List<String> lastStatus = [];

  String currentLocaleId = "";

  List<bool> hasSpeech = [];
  var res, pres;

  Widget FormHolder(int index) {
    return Card(
      margin: EdgeInsets.all(15),
      elevation: 5,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              properties[index],
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Aleo',
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontFamily: 'Aleo',
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic)),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: controllers[index],
              onChanged: (result) {
                temp[index] = result;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.mic),
                  color: Theme.of(context).accentColor,
                  onPressed: !hasSpeech[index] || speech.isListening
                      ? null
                      : () => startListening(index),
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed:
                      speech.isListening ? () => stopListening(index) : null,
                ),
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.cancel),
                  onPressed: (speech.isListening ||
                          (!speech.isListening && temp[index] != ""))
                      ? () => cancelListening(index)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context).settings.arguments;
    properties = routeArgs["properties"];
    formname = routeArgs["formname"];

    for (int i = 0; i < properties.length; i++) {
      hasSpeech.add(true);
      controllers.add(new TextEditingController());
      result.add("");
      temp.add("");
      level.add(0.0);
      lastStatus.add("");
      lastError.add("");
      initSpeechState(i);
    }
  }

  int flag = 0;
  getForm() async {
    for (int i = 0; i < properties.length; i++) {
      /* if (properties[i] == 'email') {
        details[properties[i]] = User.email;
        flag = 1;
      } else*/
      finalresult.add(controllers[i].text);
      //details[properties[i]] = controllers[i].text;
    }
    details['values'] = finalresult;
    details['email'] = formname;
    /*  if (flag == 0) {
      details['email'] = User.email;
    }*/
    print(details);
    final String url = urlInitial + "addformdetails";
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode(details),
    );
  }

  Future<void> initSpeechState(int i) async {
    bool _hasSpeech = await speech.initialize(
        onError: (error) => errorListener(error, i),
        onStatus: (status) => statusListener(status, i));
    if (_hasSpeech) {
      VoiceHome.localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      hasSpeech[i] = _hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: getForm,
            label: Text(
              "Save",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Aleo',
                  fontWeight: FontWeight.bold),
            )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.9,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, i) => FormHolder(i),
                  itemCount: properties.length,
                ),
              ),
            ],
          ),
        ));
  }

//========================================================================================================
  void startListening(int i) {
    result[i] += temp[i];
    print(result[i]);
    print(result);
    result[i] += " ";
    lastError[i] = "";
    speech.listen(
        onResult: (result) => resultListener(result, i),
        listenFor: Duration(seconds: 300),
        localeId: currentLocaleId,
        onSoundLevelChange: (level) => soundLevelListener(level, i));
    setState(() {});
  }

  void stopListening(int i) {
    speech.stop();
    setState(() {
      level[i] = 0.0;
    });
  }

  void cancelListening(int i) {
    speech.cancel();
    setState(() {
      print("Cancel is called");
      temp[i] = "";
      controllers[i].clear();
      result[i] = "";
      level[i] = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result1, int i) {
    setState(() {
      temp[i] = "${result1.recognizedWords}";
      controllers[i].text = result[i] + temp[i];
    });
  }

  void soundLevelListener(double level1, int i) {
    setState(() {
      level[i] = level1;
    });
  }

  void errorListener(SpeechRecognitionError error, int i) {
    setState(() {
      lastError[i] = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status, int i) {
    setState(() {
      lastStatus[i] = "$status";
    });
  }
}
