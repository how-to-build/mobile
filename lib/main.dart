import 'package:flutter/material.dart';
import 'package:mobile/pages/howto_page.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/register_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'How-To',
      routes: {
        '/how-to': (BuildContext context) => HowtoPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
      theme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
          accentColor: Colors.deepOrange[200],
          textTheme: TextTheme(
            headline: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
            ),
            title: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
            ),
            body1: TextStyle(
              fontSize: 18.0,
            ),
          )),
      home: RegisterPage(),
    );
  }
}
