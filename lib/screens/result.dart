import 'dart:async';
import 'package:flutter/material.dart';
import 'package:terna_app/screens/home.dart';
import 'package:flutter/services.dart';
import '../screens/upload.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../widgets/app_drawer.dart';

class Result extends StatefulWidget {
  static const routeName = '/result';
  final File imageFile;
  final String action;
  Result([this.action, this.imageFile]);

  @override
  _ResultState createState() => new _ResultState();
}

class _ResultState extends State<Result> {
  String flaskEndPoint;
  String result;

  @override
  initState() {
    result="";
    flaskEndPoint = 'http://75b868c2.ngrok.io/'+widget.action;
    super.initState();
  }

  Future getResults() async {
    print(flaskEndPoint);
    Response response;
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "file-name": await MultipartFile.fromFile(widget.imageFile.path,
          filename: "upload.jpg"),
      "param":1,
    });
    response = await dio.post(flaskEndPoint, data: formData,
        onSendProgress: (int sent, int total) {
      print("$sent / $total");
    });
    print(response.data);
    var res = response.data;


    if(res["from"]=="classifier"){
      print("from classifier");
      result+=res["data"]["classifier_data"];

    }
    else if(res["from"]=="resume"){
      print("from resume");
      result+=res["data"]["resume_data"].toString();
    }
    else if(res["from"]=="sentiment_analysis"){
      print("from sentiment");
      result+=res["data"]["sentiment_analysis"];
    }
    else{
      print("from summarizer");
      result=res["data"]["summary"];
    }
    return response.data;
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: FutureBuilder(
              future: getResults(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xff8f94fb)),),
                        SizedBox(height: 15.0,),
                        Text("Analyzing Document, Please wait.")
                      ],
                    ),
                  );
                }
//                if (snapshot.hasError) {
//                  return Text("Error");
//                }
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child:Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(child: Text(result))
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("A copy of this has been mailed to you", textAlign: TextAlign.center,),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      child: Text("Done"),
                      shape: StadiumBorder(),
                      elevation: 3.0,
                      textColor: Colors.white,
                      color: Color(0xff8f94fb),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
