import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/auth/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _sumbitAuthForm(
    String email,
    String password,
    String userName,
    File? imageFile,
    String userImageName,
    bool isSign,
  ) async {
    final _auth = FirebaseAuth.instance;
    UserCredential _userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isSign) {
        _userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseStorage.instance
            .ref(
              'image_file/${_userCredential.user!.uid}/$userImageName',
            )
            .putFile(imageFile!);

        String imageUrl = await FirebaseStorage.instance
            .ref('image_file/${_userCredential.user!.uid}/$userImageName')
            .getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(
              _userCredential.user!.uid,
            )
            .set(
          {
            'userName': userName,
            'email': email,
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occured. Please try again later.';

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );

      setState(() {
        _isLoading = false;
      });
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(
          submitAuthForm: _sumbitAuthForm,
          isLoading: _isLoading,
        ),
      ),
    );
  }
}
