import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './login_screen.dart';
import '../providers/auth.dart';
import './login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _data = {};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_data);
    try {
      await Provider.of<Auth>(context, listen: false).register(_data);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        ),
      );
    } catch (e) {
      await showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text('Signup Could not be completed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Register',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline2
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.person,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['name'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['email'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['password'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    minWidth: 150,
                    height: 50,
                    color: Theme.of(context).primaryColor,
                    onPressed: _submit,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    child: Text(
                      'Login',
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => LoginScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
