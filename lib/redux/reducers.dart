import 'package:mobile/models/app_state.dart';
import 'package:mobile/redux/actions.dart';

AppState appReducer(state, action) {
  return AppState(
      token: tokenReducer(state.token, action),
      howtos: howtosReducer(state.howtos, action));
}

tokenReducer(token, action) {
  if (action is GetTokenAction) {
    //return token from action
    return action.token;
  }
  return token;
}

howtosReducer(howtos, action) {
  if (action is GetHowtosAction) {
    return action.howtos;
  }

  return howtos;
}
