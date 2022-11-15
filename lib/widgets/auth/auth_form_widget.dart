import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({
    Key? key,
    required this.submitFn,
    required this.isLoading,
  }) : super(key: key);

  final Function submitFn;
  final bool isLoading;

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  bool _isLogin = false;

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail,
        _userPassword,
        _userName,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                    validator: (value) {
                      if (!EmailValidator.validate(value!) || value.isEmpty) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter atleast 5 character';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be atleast 7 character long!';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Log In' : 'Sign Up'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                          _isLogin ? 'Create an Account' : 'Login Instead'),
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
