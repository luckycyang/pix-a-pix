import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hint {
  Color color;
  int num;

  Hint(this.color, this.num);
}

int getMaxListLength(List<List<Hint>> lists) {
  int maxLength = 0;

  for (var list in lists) {
    if (list.length > maxLength) {
      maxLength = list.length;
    }
  }

  return maxLength;
}

class PicAPixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pic-a-Pix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PicAPixHomePage(),
    );
  }
}

class PicAPixHomePage extends StatefulWidget {
  @override
  _PicAPixHomePageState createState() => _PicAPixHomePageState();
}

class _PicAPixHomePageState extends State<PicAPixHomePage> {
  int gridSize = 5; // Default grid size
  late int margin;
  late int leftHintsMaxLen, topHintsMaxLen;
  late List<List<Color>> grid;
  late List<List<Hint>> leftHints, topHints;
  Color selectedColor = Colors.black;
  double scale = 1.0;
  late List<Color> colors;
  late List<List<Color>> solutionGrid; // The correct solution grid

  @override
  void initState() {
    super.initState();
    // Assume this is the level information containing the color palette
    colors = [Colors.black, Colors.orange, Colors.green, Colors.brown];
    selectedColor = colors[0]; // Default selected color
    leftHints = [
      [Hint(Colors.green, 3), Hint(Colors.orange, 1), Hint(Colors.green, 1)],
      [Hint(Colors.green, 1), Hint(Colors.orange, 1), Hint(Colors.green, 3)],
      [Hint(Colors.green, 2), Hint(Colors.orange, 1)],
      [Hint(Colors.brown, 1)],
      [Hint(Colors.brown, 1)],
    ];
    topHints = [
      [Hint(Colors.green, 2)],
      [Hint(Colors.green, 1), Hint(Colors.orange, 1), Hint(Colors.green, 1)],
      [Hint(Colors.brown, 2), Hint(Colors.green, 3)],
      [Hint(Colors.orange, 1), Hint(Colors.green, 1), Hint(Colors.orange, 1)],
      [Hint(Colors.green, 2)],
    ];
    leftHintsMaxLen = getMaxListLength(leftHints);
    topHintsMaxLen = getMaxListLength(topHints);
    margin = max(leftHintsMaxLen, topHintsMaxLen);
    gridSize = 5; // Adjust grid size based on hints

    // Initialize the grid with white color
    grid =
        List.generate(gridSize, (index) => List.filled(gridSize, Colors.white));

    // Define the correct solution grid
    solutionGrid = [
      [Colors.green, Colors.green, Colors.green, Colors.orange, Colors.green],
      [Colors.green, Colors.orange, Colors.green, Colors.green, Colors.green],
      [Colors.white, Colors.green, Colors.green, Colors.orange, Colors.white],
      [Colors.white, Colors.white, Colors.brown, Colors.white, Colors.white],
      [Colors.white, Colors.white, Colors.brown, Colors.white, Colors.white],
    ];
  }

  void _toggleCell(int row, int col) {
    setState(() {
      grid[row][col] =
          grid[row][col] == selectedColor ? Colors.white : selectedColor;
      _checkGameCompletion();
    });
  }

  bool _checkGameCompletion() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (grid[row][col] != solutionGrid[row][col]) {
          return false;
        }
      }
    }
    _showCompletionDialog();
    return true;
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed the puzzle!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetGrid() {
    setState(() {
      grid = List.generate(
          gridSize, (index) => List.filled(gridSize, Colors.white));
    });
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => _toggleCell(row, col),
      child: Container(
        margin: EdgeInsets.all(1.0),
        color: grid[row][col],
        width: 40.0,
        height: 40.0,
      ),
    );
  }

  Widget _buildHintCell(Hint hint) {
    return Container(
      margin: EdgeInsets.all(1.0),
      color: hint.color,
      width: 40.0,
      height: 40.0,
      child: Center(
        child: Text(
          hint.num.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Transform.scale(
      scale: scale,
      child: Column(
        children: List.generate(gridSize + margin, (row) {
          return Row(
            children: List.generate(gridSize + margin, (col) {
              if (row < margin && col < margin) {
                return Container(
                  width: 40.0,
                  height: 40.0,
                  color: Colors.grey[200],
                ); // Empty top-left corner
              } else if (row < margin) {
                // Top hints
                int hintIndex = col - margin;
                int hintRow = margin - row - 1; // Reverse the order
                if (hintIndex < topHints.length &&
                    hintRow < topHints[hintIndex].length) {
                  return _buildHintCell(topHints[hintIndex][hintRow]);
                } else {
                  return Container(
                    width: 40.0,
                    height: 40.0,
                    color: Colors.grey[200],
                  );
                }
              } else if (col < margin) {
                // Left hints
                int hintIndex = row - margin;
                if (hintIndex < leftHints.length &&
                    col < leftHints[hintIndex].length) {
                  return _buildHintCell(leftHints[hintIndex][col]);
                } else {
                  return Container(
                    width: 40.0,
                    height: 40.0,
                    color: Colors.grey[200],
                  );
                }
              } else {
                // Grid cells
                return _buildCell(row - margin, col - margin);
              }
            }),
          );
        }),
      ),
    );
  }

  Widget _buildColorPalette() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = color;
            });
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color:
                    selectedColor == color ? Colors.blue : Colors.transparent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: 40.0,
            height: 40.0,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pic-a-Pix'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGrid,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onScaleUpdate: (details) {
                setState(() {
                  scale = details.scale;
                });
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildGrid(),
                ),
              ),
            ),
          ),
          _buildColorPalette(),
        ],
      ),
    );
  }
}
