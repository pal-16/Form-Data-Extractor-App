import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../widgets/app_drawer.dart';
import 'package:dio/dio.dart';

class Resume extends StatefulWidget {
  static const routeName = '/resume';

  @override
  __ResumeState createState() => __ResumeState();
}

class __ResumeState extends State<Resume> {

  final String flaskEndPoint = 'http://75b868c2.ngrok.io/resume';

  File _storedImage;
  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _storedImage = imageFile;
    });
  }

  Future<void> _selectPicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _storedImage = imageFile;
    });
  }

  void _upload() async{
    Response response;
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(_storedImage.path, filename: "upload.jpg")
    });
    response = await dio.post(flaskEndPoint, data: formData);
    print(response.data);
  }

  Widget doneButton() {
    return _storedImage != null
        ? Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 45.0),
            child: MaterialButton(
              textColor: Colors.white,
              onPressed: () {
                _upload();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text("Done"),
              color: Theme.of(context).accentColor,
              splashColor: Colors.white,
              elevation: 5,
              shape: StadiumBorder(),
            ),
          )
        : SizedBox();
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
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Colors.grey,
              ),
            ),
            child: _storedImage != null
                ? Image.file(
                    _storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Text(
                    'Upload your resume image',
                    textAlign: TextAlign.center,
                  ),
            alignment: Alignment.center,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              color: Color.fromRGBO(143, 148, 251, 1),
              onPressed: _takePicture,
              child: Text("Take from Camera"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              color: Color.fromRGBO(143, 148, 251, 1),
              onPressed: _selectPicture,
              child: Text("Pick from Gallery"),
            ),
          ),
          doneButton(),
        ],
      ),
    );
  }
}
