import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Token actions
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

// how to actions
ThunkAction<AppState> getHowtosAction = (Store<AppState> store) async {
  http.Response response =
      await http.get("https://frozen-hamlet-77739.herokuapp.com/api/howTos/");
  final Map<String, dynamic> responseData = json.decode(response.body);
  final List<dynamic> howToList = responseData['allHowTos'];
  // final List<dynamic> responseData = json.decode(response.body);
  store.dispatch(GetHowtosAction(howToList));
};

class GetHowtosAction {
  final List<dynamic> _howtos;

  List<dynamic> get howtos => this._howtos;

  GetHowtosAction(this._howtos);
}
