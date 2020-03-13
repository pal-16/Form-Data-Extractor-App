import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../widgets/app_drawer.dart';
import '../screens/result.dart';
import 'package:dio/dio.dart';

class Upload extends StatefulWidget {
  static const routeName = '/upload';

  @override
  __UploadState createState() => __UploadState();
}

class __UploadState extends State<Upload> {
  File _storedImage;
  final String flaskEndPoint = 'http://9f5713f0.ngrok.io/'; //'http://192.168.43.208:5000/';
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
        IconButton(icon: Icon(Icons.settings), color: Colors.white, onPressed: (){})
      ],
      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
    );
  }

  Widget doneButton() {
    return _storedImage != null
        ? Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 45.0),
            child: MaterialButton(
              textColor: Colors.black,
              onPressed: () {
                _upload();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Result()));
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              color: Color.fromRGBO(143, 148, 251, 1),
              splashColor: Colors.white,
              elevation: 5,
              shape: StadiumBorder(),
            ),
          )
        : SizedBox();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey _scaffoldKey = new GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyAppDrawer(),
      appBar: appBar(_scaffoldKey),
      body: Column(
        mainAxisAlignment: _storedImage != null ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: _storedImage != null? MediaQuery.of(context).size.height * 0.5 : MediaQuery.of(context).size.height * 0.5,
              child: _storedImage != null
                  ? Image.file(
                      _storedImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.asset('assets/images/uploadlogo.jpg'),
              alignment: Alignment.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Color.fromRGBO(143, 148, 251, 1),
              onPressed: _takePicture,
              child: Text(
                "Take from Camera",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Text("or"),
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Color.fromRGBO(143, 148, 251, 1),
              onPressed: _selectPicture,
              child: Text(
                "Pick from Gallery",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
            ],
          ),
          doneButton(),
        ],
      ),
    );
  }
}
