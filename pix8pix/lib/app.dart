import 'package:flutter/material.dart';
import 'package:pix8pix/pages/home.dart';
import 'package:pix8pix/pages/page_s.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/home",
      routes: {
        '/home': (context) => Home(),
        '/a': (context) => A(),
        '/b': (context) => B(),
        '/c': (context) => C()
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/z') {
          return MaterialPageRoute(builder: (context) => C());
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => B());
      },
    );
  }
}
