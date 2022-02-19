import 'package:flutter/material.dart';

import '../widgets/auth/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void _sumbitAuthForm(
    String email,
    String password,
    String userName,
    bool isSign,
  ) {
    print('rino');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(
          submitAuthForm: _sumbitAuthForm,
        ),
      ),
    );
  }
}
