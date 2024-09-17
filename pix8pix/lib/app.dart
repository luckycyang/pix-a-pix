import 'package:flutter/material.dart';
import 'package:pix8pix/pages/tabs.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Tabs(),
    );
  }
}
