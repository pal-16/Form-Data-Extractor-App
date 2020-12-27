import 'package:flutter/material.dart';
import '../screens/signup.dart';
import '../Animation/FadeAnimation.dart';
import '../screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, name, password, type;
  int b = 0;
  bool isProcessing = false;
  bool hasFailed = false;
  final TextEditingController _emailcontroller = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _saveForm() async {
    setState(() {
      isProcessing = true;
    });
    email = _emailController.text;
    password = _passwordController.text;
    if (password.length < 8) {
      _emailController.text = "";
      _passwordController.text = "";
      print("password should be minimum 8 chars");
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "Password too short",
            style: TextStyle(fontFamily: 'Aleo', fontWeight: FontWeight.bold),
          ),
          content: Text("Password should be minimum 8 characters"),
          actions: <Widget>[
            FlatButton(
              child: Text("Okay",
                  style: TextStyle(
                      fontFamily: 'Aleo', fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } else {
      setState(() {
        if (b == 2) {
          email = _emailController.text;
          password = _passwordController.text;
          type = 'company';
        } else {
          email = _emailController.text;
          password = _passwordController.text;
          type = 'user';
        }
      });

      final String url = "http://4f7daecf.ngrok.io/applogin";
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode({
          'email': _emailcontroller.text,
          'password': _passwordController.text,
        }),
      );
      print(response.body);
      final jsonData = json.decode(response.body);
      User.email = jsonData['email'];
      User.username = jsonData['result'][0][2];
      if (jsonData['logged'] == 1) {
        final SharedPreferences prefs = await _prefs;
        prefs.setString("email", User.email);
        prefs.setString("name", User.username);
        setState(() {
          isProcessing = false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(User.username, User.email)));
      } else {
        setState(() {
          hasFailed = true;
          isProcessing = false;
        });
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.9,
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("Type of user: "),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text('Company'),
                                  Radio(
                                    activeColor: Color(0xff8f94fb),
                                    value: 2,
                                    groupValue: b,
                                    onChanged: (v) {
                                      setState(() {
                                        b = v;
                                      });
                                    },
                                  ),
                                  Text('Individual'),
                                  Radio(
                                    activeColor: Color(0xff8f94fb),
                                    value: 3,
                                    groupValue: b,
                                    onChanged: (v) {
                                      setState(() {
                                        b = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: _saveForm,
                        child: FadeAnimation(
                            2,
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        2.1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Aleo",
                                    fontSize: (16)),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: Text(
                                "Register here",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: "Aleo",
                                    fontSize: (16)),
                              ),
                              onTap: () => Navigator.of(context)
                                  .pushNamed(Signup.routeName),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
