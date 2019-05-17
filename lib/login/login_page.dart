import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github_client/config/color_config.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _readAccount();
    super.initState();
  }

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
              padding: EdgeInsets.only(
                  left: 16, top: 32, right: 16),
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
                        color: ColorConfig
                            .colorPrimaryText,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16, top: 24, right: 16),
              child: TextField(
                controller: _usernameController,
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
              padding: EdgeInsets.only(
                  left: 16, top: 24, right: 16),
              child: TextField(
                controller: _passwordController,
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
              padding: EdgeInsets.only(
                  left: 16, top: 32, right: 16),
              child: RaisedButton(
                onPressed: _login,
                textColor: Color(0xffffffff),
                color: Color(0xff1c313a),
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)),
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

  Future _login() async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    var url = "https://api.github.com/authorizations";
    var token = base64.encode(utf8.encode("$username:$password"));
    var requestBody = json.encode({
      "scopes": ["user", "repo", "gist", "notifications"],
      "note": "com.github.flutter_client",
      "client_id": "d9565c1bc303bed1f774",
      "client_secret": "18ca2e238d25ade1bf08fc0ca9e33060a3145747"
    });

    var response = await http.post(url,
        headers: {
          'Authorization': 'basic $token',
          'Accept': 'application/json',
        },
        body: requestBody);
    if (response.statusCode == 201) {
      final body = json.decode(response.body);
      _saveAccount(username, password);
//      _fetchUserInfo(token);
      print("$body");
    } else {
      Fluttertoast.showToast(
          msg: "Username or Password invalid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
  }

  Future _fetchUserInfo(String token) async {
    var url = "https://api.github.com/user";

    var response = await http.get(url, headers: {'Authorization': 'basic $token'});
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print("$body");
    } else {
      Fluttertoast.showToast(
          msg: "Fetch user info failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
  }

  _saveAccount(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future _readAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _usernameController.text = prefs.getString('username');
    _passwordController.text = prefs.getString('password');
    print("username:${prefs.getString('username')} ${prefs.getString('password')}");
  }
}
