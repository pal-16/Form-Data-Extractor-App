import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String username, email;
  EditProfile(this.username, this.email);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController, usernameController;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);
    usernameController = TextEditingController(text: widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8f94fb),
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
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
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
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}
