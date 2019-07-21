import 'package:flutter/material.dart';

class HowToItem extends StatelessWidget {
  final dynamic item;

  HowToItem({this.item});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        title: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
        subtitle: Text(
          item['username'],
          style: TextStyle(fontSize: 20.0),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(
            image: NetworkImage('${item['avatar']}' != 'default'
                ? '${item['avatar']}'
                : 'http://cdn.onlinewebfonts.com/svg/img_304664.png'),
          ),
        ),
        trailing: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.thumb_up),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${item['likes']}'),
            )
          ],
        ),
        backgroundColor: Colors.black45,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
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
      ),
    );
  }
}
