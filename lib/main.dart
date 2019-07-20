import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/models/app_state.dart';
import 'package:mobile/pages/howto_page.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/register_page.dart';
import 'package:mobile/redux/actions.dart';
import 'package:mobile/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'How-To',
        routes: {
          '/how-to': (BuildContext context) => HowtoPage(onInit: () {
                StoreProvider.of<AppState>(context).dispatch(getTokenAction);
                StoreProvider.of<AppState>(context).dispatch(getHowtosAction);
              }),
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
      ),
    );
  }
}
