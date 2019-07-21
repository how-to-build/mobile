import 'package:mobile/models/app_state.dart';
import 'package:mobile/models/userObject.dart';
import 'package:mobile/redux/actions.dart';

AppState appReducer(state, action) {
  return AppState(
    token: tokenReducer(state.token, action),
    howtos: howtosReducer(state.howtos, action),
    username: usernameReducer(state.username, action),
    userObject: userObjectReducer(state.userObject, action),
  );
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

usernameReducer(username, action) {
  if (action is GetUsernameAction) {
    return action.username;
  }

  return username;
}

userObjectReducer(UserObject userObject, action) {
  if (action is GetUserObjectAction) {
    return action.userObject;
  }

  return userObject;
}
