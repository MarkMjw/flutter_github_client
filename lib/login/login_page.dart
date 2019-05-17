import 'package:flutter/material.dart';
import 'package:flutter_github_client/config/color_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 42.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, top: 32, right: 16),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/image/ic_github.png',
                    width: 65,
                    height: 65,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Sing in to Github',
                      style: TextStyle(
                        color: ColorConfig.colorPrimaryText,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 24, right: 16),
              child: TextField(
                controller: userController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.account_circle),
                  labelText: 'Username or email address',
                ),
                autofocus: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 24, right: 16),
              child: TextField(
                controller: passController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.linear_scale),
                  labelText: 'Password',
                ),
                autofocus: false,
                obscureText: true,
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, top: 32, right: 16),
              child: RaisedButton(
                onPressed: login,
                textColor: Color(0xffffffff),
                color: Color(0xff1c313a),
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  'Sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() {}
}
