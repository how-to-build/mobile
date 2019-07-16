import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      print('Username:  Email: $_email, Password: $_password');
    }
  }

  void _loginUser() async {
    http.Response response = await http.post(
        'https://frozen-hamlet-77739.herokuapp.com/api/login',
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"email": _email, "password": _password}));

    final responseData = json.decode(response.body);
    print(responseData);
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
        onSaved: (val) => _email = val,
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
