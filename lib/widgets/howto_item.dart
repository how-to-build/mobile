import 'package:flutter/material.dart';

class HowToItem extends StatelessWidget {
  final dynamic item;

  HowToItem({this.item});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        title: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
        subtitle: Text(
          item['username'],
          style: TextStyle(fontSize: 20.0),
        ),
        backgroundColor: Colors.black45,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item['description'],
            ),
          ),
        ],
      ),
    );
  }
}
