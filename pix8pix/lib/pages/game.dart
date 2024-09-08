import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int gridSize = 5;
  late List<List<Color>> grid;
  Color selectedColor = Colors.green;

  @override
  void initState() {
    super.initState();
    grid = List.generate(
        gridSize, (i) => List.generate(gridSize, (j) => Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Game'),
        actions: [
          IconButton(icon: Icon(Icons.undo), onPressed: () {}),
          IconButton(icon: Icon(Icons.redo), onPressed: () {}),
          IconButton(icon: Icon(Icons.color_lens), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          buildNumberRow(),
          Expanded(
            child: Row(
              children: [
                buildNumberColumn(),
                Expanded(child: buildGrid()),
              ],
            ),
          ),
          buildColorPicker(),
        ],
      ),
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ gridSize;
        int col = index % gridSize;
        return GestureDetector(
          onTap: () {
            setState(() {
              grid[row][col] = selectedColor;
            });
          },
          child: Container(
            margin: EdgeInsets.all(1),
            color: grid[row][col],
          ),
        );
      },
      itemCount: gridSize * gridSize,
    );
  }

  Widget buildNumberRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(gridSize, (index) {
        return Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Text('1', style: TextStyle(fontSize: 20)),
        );
      }),
    );
  }

  Widget buildNumberColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(gridSize, (index) {
        return Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Text('1', style: TextStyle(fontSize: 20)),
        );
      }),
    );
  }

  Widget buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildColorButton(Colors.green),
        buildColorButton(Colors.orange),
        buildColorButton(Colors.brown),
      ],
    );
  }

  Widget buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        width: 40,
        height: 40,
        color: color,
      ),
    );
  }
}
