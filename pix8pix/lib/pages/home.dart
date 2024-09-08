import 'package:flutter/material.dart';
import 'package:pix8pix/pages/page_s.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              var res = Navigator.pushNamed(context, '/a', arguments: '114514');
              res.then((value) => print(value));
            },
            icon: Icon(Icons.home),
            label: Text('home')),
      ),
    );
  }
}
