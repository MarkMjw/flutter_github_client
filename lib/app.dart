import 'package:flutter/material.dart';
import 'package:flutter_github_client/config/color_config.dart';
import 'package:flutter_github_client/login/login_page.dart';

void main() => runApp(new GithubApp());

class GithubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Github',
        theme: new ThemeData(
          accentColor: ColorConfig.colorPrimary,
          primaryColorDark: ColorConfig.colorPrimary,
          primaryColor: ColorConfig.colorPrimary,
        ),
        home: new LoginPage());
  }
}
