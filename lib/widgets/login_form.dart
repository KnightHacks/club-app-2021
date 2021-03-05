import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/accountview.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
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


  void _login(BuildContext context) async {

    if (!_formKey.currentState.validate()) {
      return null;
    }

    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      // Try to sign user in.
      AuthResult res = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
          password: password);
      
      FirebaseUser user = res.user;

      if(user.isEmailVerified){
        // Move to home page.
        Navigator.popAndPushNamed(context, AccountView.id);
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Please check email for verification link"),
              actions: <Widget>[
                new FlatButton(onPressed: () => Navigator.of(context).pop(),
                    child: Text("Close"))
              ],
            );
          },
        );
      }
    } catch(e) {
      // Show error dialog
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
    }
  }

  void dispose() {
    // Dispose any controllers created.
    _emailController.dispose();
    _passwordController.dispose();
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
          RoundedTextInput(
            validator: _validateEmail,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: "Email",
            autocorrect: false,
          ),
          SizedBox(height: 20),
          RoundedTextInput(
            validator: _validatePassword,
            controller: _passwordController,
            labelText: "Password",
            obscureText: true,
          ),
          SizedBox(height: 20),
          RoundedButton(
            onPressed: () => _login(context),
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
