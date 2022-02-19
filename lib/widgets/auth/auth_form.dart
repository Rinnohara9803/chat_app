import 'dart:io';

import 'package:flutter/material.dart';

import 'add_image_widget.dart';

class AuthForm extends StatefulWidget {
  final Function submitAuthForm;
  final bool isLoading;
  const AuthForm({
    required this.submitAuthForm,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSignIn = true;
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  File? _userProfilePhoto;

  void _getUserProfilePhoto(File imageFile) {
    _userProfilePhoto = imageFile;
  }

  void _changeAuthState() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  void _submitForm() {
    if (_userProfilePhoto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick an image.'),
          backgroundColor: Colors.redAccent.withOpacity(
            0.7,
          ),
        ),
      );
      return;
    }
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
                      AddImageWidget(
                        getUserProfilePhoto: _getUserProfilePhoto,
                      ),
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
                        child: widget.isLoading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : Text(
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
