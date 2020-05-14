import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/model.dart';
import '../screens/home.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/editprofile';

  final String username, email, password;

  EditProfile(this.username, this.email, this.password);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController passwordController, usernameController, emailController;

  @override
  void initState() {
    passwordController = TextEditingController(text: widget.password);
    usernameController = TextEditingController(text: widget.username);
    emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  void saveinfo() async {
    final String url = "http://2ec43766.ngrok.io/appeditprofile";
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'email': User.email,
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );
    //show the message that info got updated
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8f94fb),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
        child: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Text(
                widget.username[0],
                style: TextStyle(
                  color: Color(0xff8f94fb),
                  fontSize: 60.0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: usernameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
              ),
              readOnly: true,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: RaisedButton(
                shape: StadiumBorder(),
                elevation: 10.0,
                child: Text(
                  "Update Info",
                  style: TextStyle(color: Color(0xff8f94fb)),
                ),
                color: Colors.white,
                onPressed: saveinfo,
              ),
            )
          ],
        ),
      ),
    );
  }
}