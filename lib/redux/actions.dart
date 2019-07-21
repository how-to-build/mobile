import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/app_state.dart';
import 'package:mobile/models/userObject.dart';
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

ThunkAction<AppState> getUsernameAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUsername = prefs.getString('username');
  final username = storedUsername != null ? json.decode(storedUsername) : null;
  store.dispatch(GetUsernameAction(username));
};

class GetTokenAction {
  final dynamic _token;

  dynamic get token => this._token;

  GetTokenAction(this._token);
}

class GetUsernameAction {
  final String _username;

  String get username => this._username;

  GetUsernameAction(this._username);
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

// how to actions
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  http.Response response =
      await http.get("https://frozen-hamlet-77739.herokuapp.com/api/users/");
  final Map<String, dynamic> responseData = json.decode(response.body);
  final List<dynamic> howToList = responseData['allHowTos'];
  // final List<dynamic> responseData = json.decode(response.body);
  store.dispatch(GetHowtosAction(howToList));
};

class GetUserAction {
  final Map<String, dynamic> _user;

  Map<String, dynamic> get user => this._user;

  GetUserAction(this._user);
}

// User action
ThunkAction<AppState> getUserObjectAction = (Store<AppState> store) async {
  http.Response response = await http.get(
      'https://frozen-hamlet-77739.herokuapp.com/api/users/${store.state.username}');
  final Map<String, dynamic> responseData = json.decode(response.body);
  final UserObject userObject = UserObject.fromJson(responseData['user']);
  // final List<dynamic> responseData = json.decode(response.body);
  store.dispatch(GetUserObjectAction(userObject));
};

class GetUserObjectAction {
  final UserObject _userObject;

  UserObject get userObject => this._userObject;

  GetUserObjectAction(this._userObject);
}
