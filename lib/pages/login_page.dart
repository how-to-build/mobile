import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSubmitting, _obscureText = true;

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register'),
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
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _showFormActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _submit,
            child: Text(
              'Submit',
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
          FlatButton(
            child: Text(
              'New user? Register',
            ),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/register'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _loginUser();
    }
  }

  void _loginUser() async {
    setState(() => _isSubmitting = true);

    http.Response response = await http.post(
        'https://frozen-hamlet-77739.herokuapp.com/api/login',
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"email": _email, "password": _password}));
    final responseData = json.decode(response.body);
    _storeUserData(responseData);
    print(responseData);

    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();

      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = responseData['message'];
      _showErrorSnack(errorMsg);
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    String token = responseData['token'];
    String username = responseData['username'];
    // json.encode(token);
    prefs.setString('token', json.encode(token));
    prefs.setString('username', json.encode(username));
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/how-to');
    });
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: Text(
        'Loggin Successful.',
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

    throw Exception('Login Failure: $errorMsg');
  }

  Text _showTitle(BuildContext context) {
    return Text(
      'Login',
      style: Theme.of(context).textTheme.headline,
    );
  }

  Padding _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _password = val,
        obscureText: _obscureText,
        validator: (val) => val.length < 6 ? 'Requires 6 characters' : null,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() => _obscureText = !_obscureText);
            },
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(),
          labelText: 'Password',
          hintText: 'Enter password, min length 6',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Padding _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _email = val.replaceAll(new RegExp(r"\s+\b|\b\s"), "").trim().toLowerCase(),
        validator: (val) => !val.contains('@') ? "Not a valid email" : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter a valid email',
          icon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
