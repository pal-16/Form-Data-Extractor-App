import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/feedbackk.dart';
import '../screens/upload.dart';
import '../screens/summarize.dart';
import '../screens/resume.dart';

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
            Container(
              color: Colors.white,
              width: double.infinity,
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).size.height * 0.01) *
                  0.3
                  : (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).size.height * 0.07) *
                  0.5,
              alignment: Alignment.center,

              child: Image.asset(
                'assets/images/form.png',
                width: double.infinity,
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
                    onTap: ()=>Navigator.of(context).pushReplacementNamed(Home.routeName),
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
                   onTap: ()=>Navigator.of(context).pushReplacementNamed(Upload.routeName),
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
                    onTap: ()=>Navigator.of(context).pushReplacementNamed(Resume.routeName),
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
                   onTap: ()=>Navigator.of(context).pushReplacementNamed(Summarize.routeName),
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
                onTap: ()=>Navigator.of(context).pushReplacementNamed(Feedbackk.routeName),
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
                  ), Divider(),
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