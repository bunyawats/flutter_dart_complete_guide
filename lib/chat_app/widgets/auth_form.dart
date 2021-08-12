import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) onSummit;

  const AuthForm(
    this.onSummit, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _email = '';
  var _userName = '';
  var _password = '';

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.onSummit(
        _email,
        _password,
        _userName,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _email = value ?? '';
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Password must be at least 4 characters long';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _userName = value ?? '';
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value ?? '';
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(
                      _isLogin ? 'Login' : 'Signup',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin ? 'Create new account' : 'I have an account',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
