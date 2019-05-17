import 'package:flutter/material.dart';
import 'package:flutter_github_client/config/color_config.dart';
import 'package:flutter_github_client/main/home_page.dart';
import 'package:flutter_github_client/main/repo_page.dart';
import 'package:flutter_github_client/main/me_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _tabIndex = 0;
  var tabTitles;
  var tabImages;

  var _pages;
  var pageController;

  @override
  void initState() {
    _initTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          _pages[0],
          _pages[1],
          _pages[2],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildItem(0),
          _buildItem(1),
          _buildItem(2),
        ],
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        fixedColor: ColorConfig.colorPrimary,
        backgroundColor: ColorConfig.colorPrimary,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
          pageController.jumpToPage(_tabIndex);
        },
      ),
    );
  }

  BottomNavigationBarItem _buildItem(int index) {
    return BottomNavigationBarItem(
        icon: tabImages[index][index == _tabIndex ? 1 : 0],
        title: Text(
          tabTitles[index],
          style: TextStyle(
            color: index == _tabIndex ? Color(0xffcfd8dc) : Color(0xff718792),
          ),
        ));
  }

  void _initTab() {
    tabTitles = ['Home', 'Repo', 'Me'];
    tabImages = [
      [_getTabImage('images/ic_nav_home.png'), _getTabImage('images/ic_nav_home_white.png')],
      [_getTabImage('images/ic_nav_task.png'), _getTabImage('images/ic_nav_task_white.png')],
      [_getTabImage('images/ic_nav_mine.png'), _getTabImage('images/ic_nav_mine_white.png')],
    ];
    _pages = [HomePage(), RepoPage(), MePage()];
    pageController = PageController(initialPage: _tabIndex, keepPage: true);
  }

  Image _getTabImage(path) {
    return new Image.asset(path, width: 28, height: 28);
  }
}
