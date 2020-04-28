import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceHome extends StatefulWidget {
  static List<LocaleName> localeNames = [];
  static const String routeName = '/voice-home';

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  final SpeechToText speech = SpeechToText();

  List<dynamic> properties;

  // Do not change any list definitions from List<...> ... = [] to List<...> ... = new List()
  List<String> form = [];

  List<TextEditingController> controllers = [];

  List<String> result = [];

  List<String> temp = [];

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
            onPressed: () async {
              for (int i = 0; i < properties.length; i++) {
                form.add(controllers[i].text);
              }
              print(form);
            },
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
//              Card(
//                margin: EdgeInsets.all(15),
//                elevation: 5,
//                child: Container(
//                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Text(
//                        widget.properties[1],
//                        style: TextStyle(
//                            fontFamily: 'Aleo',
//                            fontSize: 20,
//                            fontWeight: FontWeight.bold),
//                      ),
//                      TextField(
//                        decoration: InputDecoration(
//                            hintText: "Fever...",
//                            hintStyle: TextStyle(
//                                fontFamily: 'Aleo',
//                                color: Colors.grey,
//                                fontSize: 16.0,
//                                fontStyle: FontStyle.italic)),
//                        keyboardType: TextInputType.multiline,
//                        maxLines: null,
//                        controller: controllers[1],
//                        onChanged: (result) {
//                          temp[1] = result;
//                        },
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          IconButton(
//                            color: Theme.of(context).accentColor,
//                            icon: Icon(Icons.mic),
//                            onPressed: !hasSpeech[1] || speech.isListening
//                                ? null
//                                : () => startListening(1),
//                          ),
//                          IconButton(
//                            icon: Icon(Icons.stop),
//                            onPressed: speech.isListening
//                                ? () => stopListening(1)
//                                : null,
//                          ),
//                          IconButton(
//                            color: Colors.red,
//                            icon: Icon(Icons.cancel),
//                            onPressed: (speech.isListening ||
//                                    (!speech.isListening && temp[1] != ""))
//                                ? () => cancelListening(1)
//                                : null,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Container(
//                child: Card(
//                  margin: EdgeInsets.all(15),
//                  elevation: 5,
//                  child: Container(
//                    width: double.infinity,
//                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                    ),
//                  ),
//                ),
//              ),
//              GestureDetector(
//                child: Card(
//                  margin: EdgeInsets.all(15),
//                  elevation: 5,
//                  child: Container(
//                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Text(
//                          widget.properties[2],
//                          style: TextStyle(
//                              fontSize: 20,
//                              fontFamily: 'Aleo',
//                              fontWeight: FontWeight.bold),
//                        ),
//                        TextField(
//                          decoration: InputDecoration(
//                              hintText: "Initial Diagnosis",
//                              hintStyle: TextStyle(
//                                  fontFamily: 'Aleo',
//                                  color: Colors.grey,
//                                  fontSize: 16.0,
//                                  fontStyle: FontStyle.italic)),
//                          keyboardType: TextInputType.multiline,
//                          maxLines: null,
//                          controller: controllers[2],
//                          onChanged: (result) {
//                            temp[2] = result;
//                          },
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            IconButton(
//                              color: Theme.of(context).accentColor,
//                              icon: Icon(Icons.mic),
//                              onPressed: !hasSpeech[2] || speech.isListening
//                                  ? null
//                                  : () => startListening(2),
//                            ),
//                            IconButton(
//                              icon: Icon(Icons.stop),
//                              onPressed: speech.isListening
//                                  ? () => stopListening(2)
//                                  : null,
//                            ),
//                            IconButton(
//                              color: Colors.red,
//                              icon: Icon(Icons.cancel),
//                              onPressed: (speech.isListening ||
//                                      (!speech.isListening && temp[2] != ""))
//                                  ? () => cancelListening(2)
//                                  : null,
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//              Card(
//                margin: EdgeInsets.all(15),
//                elevation: 5,
//                child: Container(
//                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Text(
//                        widget.properties[3],
//                        style: TextStyle(
//                            fontSize: 20,
//                            fontFamily: 'Aleo',
//                            fontWeight: FontWeight.bold),
//                      ),
//                      TextField(
//                        decoration: InputDecoration(
//                            hintText: "Tablets, syrups or creams...",
//                            hintStyle: TextStyle(
//                                fontFamily: 'Aleo',
//                                color: Colors.grey,
//                                fontSize: 16.0,
//                                fontStyle: FontStyle.italic)),
//                        keyboardType: TextInputType.multiline,
//                        maxLines: null,
//                        controller: controllers[3],
//                        onChanged: (result) {
//                          temp[3] = result;
//                        },
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          IconButton(
//                            color: Theme.of(context).accentColor,
//                            icon: Icon(Icons.mic),
//                            onPressed: !hasSpeech[3] || speech.isListening
//                                ? null
//                                : () => startListening(3),
//                          ),
//                          IconButton(
//                            icon: Icon(Icons.stop),
//                            onPressed: speech.isListening
//                                ? () => stopListening(3)
//                                : null,
//                          ),
//                          IconButton(
//                            color: Colors.red,
//                            icon: Icon(Icons.cancel),
//                            onPressed: (speech.isListening ||
//                                    (!speech.isListening && temp[3] != ""))
//                                ? () => cancelListening(3)
//                                : null,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              GestureDetector(
//                onTap: () {},
//                child: Card(
//                  margin: EdgeInsets.all(15),
//                  elevation: 5,
//                  child: Container(
//                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Text(
//                          widget.properties[4],
//                          style: TextStyle(
//                              fontSize: 20,
//                              fontFamily: 'Aleo',
//                              fontWeight: FontWeight.bold),
//                        ),
//                        TextField(
//                          decoration: InputDecoration(
//                              hintText: "Healthy Diet...",
//                              hintStyle: TextStyle(
//                                  fontFamily: 'Aleo',
//                                  color: Colors.grey,
//                                  fontSize: 16.0,
//                                  fontStyle: FontStyle.italic)),
//                          keyboardType: TextInputType.multiline,
//                          maxLines: null,
//                          controller: controllers[4],
//                          onChanged: (result) {
//                            temp[4] = result;
//                          },
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            IconButton(
//                              color: Theme.of(context).accentColor,
//                              icon: Icon(Icons.mic),
//                              onPressed: !hasSpeech[4] || speech.isListening
//                                  ? null
//                                  : () => startListening(4),
//                            ),
//                            IconButton(
//                              icon: Icon(Icons.stop),
//                              onPressed: speech.isListening
//                                  ? () => stopListening(0)
//                                  : null,
//                            ),
//                            IconButton(
//                              color: Colors.red,
//                              icon: Icon(Icons.cancel),
//                              onPressed: (speech.isListening ||
//                                      (!speech.isListening && temp[4] != ""))
//                                  ? () => cancelListening(4)
//                                  : null,
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              )
            ],
          ),
        ));
  }

//========================================================================================================
  void startListening(int i) {
    result[i] += temp[i];
    print(result[i]);
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
