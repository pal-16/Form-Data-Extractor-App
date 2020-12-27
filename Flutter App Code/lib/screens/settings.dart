import 'package:flutter/material.dart';
import 'package:terna_app/screens/edit_profile.dart';

class SettingsPage extends StatelessWidget {
  final String username, password, email;
  SettingsPage(
      [this.username = "Anonymus",
        this.email = "Anonymus",
        this.password = "Anonymus"]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8f94fb),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Settings",
                  style: TextStyle(color: Colors.white, fontSize: 35.0),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Text(
                    username[0],
                    style: TextStyle(
                      fontSize: 35,
                      color: Color(0xff8f94fb),
                    ),
                  ),
                ),
                Text(
                  "    $username\n    $email",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Text(
                    "My Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfile(username, email, password))),
                ),
                ListTile(
                  leading: Icon(
                    Icons.feedback,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Text(
                    "Feedback",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Text(
                    "About Us",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}