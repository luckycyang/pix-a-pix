import 'package:flutter/material.dart';
import 'package:pix8pix/res/listData.dart';

class ScoreBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('排行榜'),
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, index) {
          // 计算分数
          int score = 100 - 2 * index;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listData[index]['imageUrl']),
            ),
            title: Text(listData[index]['title']),
            subtitle: Text('Score: $score'),
            trailing: Text('Rank: ${index + 1}'),
          );
        },
      ),
    );
  }
}
