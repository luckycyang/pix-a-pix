import 'package:flutter/material.dart';
import 'package:pix8pix/pages/tabs/levels.dart';
import 'package:pix8pix/pages/tabs/profile.dart';
import 'package:pix8pix/pages/tabs/ranking.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    Levels(),
    ScoreBoard(),
    LoginPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("App Name"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_sharp), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.align_vertical_bottom), label: '排行榜'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '个人'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}
