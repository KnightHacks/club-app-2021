import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class ValidationResult {
  bool success = false;
  String message = "";

  ValidationResult({this.success, this.message});
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String Function(String) _validatePassword = (String value) {
    return value.isEmpty ? "Please enter password" : null;
  };

  final String Function(String) _validateEmail = (String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    }

    if (!EmailValidator.validate(value)) {
      return "Please enter valid email";
    }

    return null;
  };

  Future<AuthResult> _sendLogin(String email, String password) {


  }

  Future<String> _login(BuildContext context) async {

    if (!_formKey.currentState.validate()) {
      return null;
    }

    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
          password: password);
    } catch(e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Could not login"),
              actions: <Widget>[
                new FlatButton(onPressed: () => Navigator.of(context).pop(),
                    child: Text("Close"))
              ],
            );
          },
      );
      print(e.message);
    }

    Scaffold.of(context)
    .showSnackBar(SnackBar(content: Text("Logging In...")));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            validator: _validateEmail,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                  labelText: "Email"
            ),
          ),
          TextFormField(
            validator: _validatePassword,
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Password"
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => _login(context),
              child: Text("Login"),
          )
        ],
      ),
    );
  }
}