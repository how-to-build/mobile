import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HowtoPage extends StatefulWidget {
  @override
  HowtoPageState createState() => HowtoPageState();
}

class HowtoPageState extends State<HowtoPage> {
  void initState() {
    super.initState();

    _getUser();
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storedToken = prefs.getString('token');
    print(json.decode(storedToken));
  }

  @override
  Widget build(BuildContext context) {
    return Text('How To');
  }
}
