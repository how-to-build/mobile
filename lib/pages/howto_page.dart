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
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(state.username),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Create How-To'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
