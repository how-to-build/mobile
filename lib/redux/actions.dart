import 'dart:convert';

import 'package:mobile/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Tokenr action
ThunkAction<AppState> getTokenAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedToken = prefs.getString('token');
  final token = storedToken != null ? json.decode(storedToken) : null;
  store.dispatch(GetTokenAction(token));
};

class GetTokenAction {
  final dynamic _token;

  dynamic get token => this._token;

  GetTokenAction(this._token);
}
