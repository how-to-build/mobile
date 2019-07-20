import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/models/app_state.dart';

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

//not needed any longer
  // _getUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var storedToken = prefs.getString('token');
  //   print(json.decode(storedToken));
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return Text(json.encode(state.token));
            },
          );
        });
  }
}
