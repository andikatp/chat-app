import 'package:chat_app/widgets/auth_form_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/Auth-Screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ) async {
    UserCredential userCred;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCred.user?.uid)
            .set({'username': username, 'email': email});
      }
      
    } on FirebaseAuthException catch (error) {
      String messages = 'An Errpr occured, please check your credentials!';
      if (error.message != null) {
        messages = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messages),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      rethrow;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(submitFn: _submitAuthForm,  isLoading: _isLoading,),
    );
  }
}
