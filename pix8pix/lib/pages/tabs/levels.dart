import 'package:flutter/material.dart';
import 'package:pix8pix/pages/game.dart';

class Levels extends StatefulWidget {
  const Levels({super.key});

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(onPressed: _onPressed, child: Text("游戏界面")),
    );
  }

  void _onPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PicAPixApp();
    }));
  }
}
