import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/models/app_state.dart';
import 'package:mobile/widgets/howto_item.dart';

final gradientBackground = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [
        0.1,
        0.3,
        0.5,
        0.7,
        0.9
      ],
      colors: [
        Colors.white70,
        Colors.white60,
        Colors.white54,
        Colors.white30,
        Colors.white24
      ]),
);

class HowtoPage extends StatefulWidget {
  final void Function() onInit;
  HowtoPage({this.onInit});

  @override
  HowtoPageState createState() => HowtoPageState();
}

class HowtoPageState extends State<HowtoPage> {
  void initState() {
    super.initState();

    widget.onInit();
  }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(
            child: Text('How Tos'),
          ),
          // leading: Icon(Icons.menu),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () => print('Clicked'),
                  ),
                ],
              ),
            )
          ],
        );
      },
    ),
  );

  @override
  //now able to pull token from state.token
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: gradientBackground,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: SafeArea(
                  top: false,
                  bottom: false,
                  child: GridView.builder(
                    itemCount: state.howtos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    itemBuilder: (context, i) =>
                        HowToItem(item: state.howtos[i]),
                  ),
                ))
              ],
            );
          },
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
