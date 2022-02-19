import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function submitAuthForm;
  const AuthForm({required this.submitAuthForm, Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSignIn = true;
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';

  void _changeAuthState() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    widget.submitAuthForm(
      _userEmail,
      _userPassword,
      _userName,
      _isSignIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isSignIn)
                      TextFormField(
                        key: UniqueKey(),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your username.';
                          } else if (value.trim().length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value!;
                        },
                      ),
                    TextFormField(
                      key: UniqueKey(),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter your username.';
                        } else if (!value.contains('@') ||
                            !value.endsWith('.com')) {
                          return 'Please provide a valid email.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                    ),
                    TextFormField(
                      key: UniqueKey(),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter your username.';
                        } else if (value.trim().length < 7) {
                          return 'Please enter at least 7 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          _isSignIn ? 'Sign In' : 'Sign Up',
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        _isSignIn ? 'Create new account' : 'Sign In',
                      ),
                      onPressed: _changeAuthState,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
