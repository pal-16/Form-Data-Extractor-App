import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/feedbackk.dart';
import '../screens/upload.dart';
import '../screens/summarize.dart';
import '../screens/resume.dart';
import '../screens/login.dart';

class AppDrawer extends StatelessWidget {
  final AppBar appBar;

  AppDrawer(this.appBar);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Container(
        color: Color.fromRGBO(143, 148, 251, 1),
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/images/form.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).size.height * 0.01) *
                      0.82
                  : (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).size.height * 0.07) *
                      0.9,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(Home.routeName),
                    child: ListTile(
                      leading: Icon(
                        Icons.movie,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(Upload.routeName),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Upload",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(Resume.routeName),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Resume",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(Summarize.routeName),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Summarizer",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(Feedbackk.routeName),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Feedback Form",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Share",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyAppDrawer extends StatelessWidget {

  MyAppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(143, 148, 251, 1), Color.fromRGBO(160, 148, 251, 1)],
        )),
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/images/me.png'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Mohammed Mehdi",
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              ),
            )),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white,),
              onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home())),
                title: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            ListTile(
              leading: Icon(Icons.file_upload, color: Colors.white,),
              onTap: (){
                Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Upload()));
              },
                title: Text(
              "Upload",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            ListTile(
              leading: Icon(Icons.book, color: Colors.white,),
                title: Text(
              "Summarizer",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white,),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(Login.routeName);
              },
                title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
