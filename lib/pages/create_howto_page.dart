import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/app_state.dart';

class CreateHowToPage extends StatefulWidget {
  @override
  _CreateHowToPageState createState() => _CreateHowToPageState();
}

class _CreateHowToPageState extends State<CreateHowToPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSubmitting;

  String _title, _description;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Create How To'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _showTitle(context),
                        _showHowToTitleInput(),
                        _showHowToDescriptionInput(),
                        _showFormActions(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  StoreConnector _showFormActions(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                _isSubmitting == true
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      )
                    : RaisedButton(
                        onPressed: _submit,
                        child: Text(
                          'Add How To',
                          style: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                      ),
              ],
            ),
          );
        });
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _createHowTo();
      print('Title: $_title, Description: $_description');
    }
  }

  void _createHowTo() async {
    setState(() => _isSubmitting = true);
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWJqZWN0Ijo2NywidXNlcm5hbWUiOiJpbmVybG9mZ3JlbjQyIiwiaWF0IjoxNTYzNzU1NzYzLCJleHAiOjE1NjM3OTE3NjN9.4i1xQVk-5u3GhRlTQbYbyQV0kVUfbpSiCuIpRTcykkQ";
    print('this is the token ===> ');
    http.Response response = await http.post(
        'https://frozen-hamlet-77739.herokuapp.com/api/howTos',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        },
        body: json.encode(
            {"title": _title, "description": _description, "user_id": 67}));
    final responseData = json.decode(response.body);
    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);

      _showSuccessSnack();
      _redirectUser();

      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = responseData['message'];
      _showErrorSnack(errorMsg);
    }
  }

// TODO: refactor to push to steps page
  void _redirectUser() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/how-to');
    });
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: Text(
        'How To successfully created!',
        style: TextStyle(color: Colors.green),
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar = SnackBar(
      content: Text(
        errorMsg,
        style: TextStyle(color: Colors.red),
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);

    throw Exception('Error adding How To');
  }

  Text _showTitle(BuildContext context) {
    return Text(
      'Create How To',
      style: Theme.of(context).textTheme.headline,
    );
  }

  Padding _showHowToTitleInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _title = val,
        validator: (val) => val.length < 3 ? 'Requires 3 characters' : null,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.face,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(),
          labelText: 'How To Title',
          hintText: 'Enter How To title, min length of 3',
        ),
      ),
    );
  }

  Padding _showHowToDescriptionInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        onSaved: (val) => _description = val,
        validator: (val) => val.length < 3 ? 'Requires 3 characters' : null,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.face,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(),
          labelText: 'How To Description',
          hintText: 'Enter description, min length of 3',
        ),
      ),
    );
  }
}
