import 'package:club_app_2021/constants.dart';
import 'package:club_app_2021/screens/home.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/resetpassword.dart';

/// This widget handles login.
/// 
/// This widget handles text input, validation, and navigation to the register
/// page. It utilizes custom text input and button widgets.
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// This method checks if the password field is empty.
  final String Function(String) _validatePassword = (String value) {
    return value.isEmpty ? "Please enter password" : null;
  };

  /// This method checks if the entered email is empty or if it is not a
  /// knights email.
  final String Function(String) _validateEmail = (String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    }
    if (!EmailValidator.validate(value) && (value.contains(knightsEmail) || value.contains(ucfEmail))) {
      return "Please enter valid knights email";
    }
    return null;
  };

  /// This method logs the user in.
  /// 
  /// It attempts to log the user in with the entered email and password. 
  /// If the login succeeds, it checks if the user has verified their email.
  /// If they have not, then an alert is rendered. If they have, then it
  /// navigates to the home page. If login fails
  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      throw new Error();
    }

    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      // Try to sign user in.
      AuthResult res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = res.user;

      if (user.isEmailVerified) {
        Navigator.popAndPushNamed(context, Home.id);
      } else {
        /// Renders a popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Please check email for verification link"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Close"))
              ],
            );
          },
        );
      }
    } catch(e) {
      throw e;
    }
  }

  void dispose() {
    // Dispose any controllers created.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Renders a loading dialogue when the login button is pressed.
  Future<void> showLoadingDialogue(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF36328B),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [CircularProgressIndicator(
              value: null,
            ), Text('Loading')
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  /// Renders a form widget that contains the inputs for email and password. 
  /// 
  /// The login button calls _login and the register button navigates to the register1 page.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          height: 400,
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
               onPressed: () {
                 _login(context).then((value) {
                   Navigator.of(context, rootNavigator: true).pop('dialog');
                   Navigator.popAndPushNamed(context, Home.id);
                 })
                 .catchError((err) {
                   Navigator.of(context, rootNavigator: true).pop('dialog');
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
                 });
                 showLoadingDialogue(context);
               },
               child: Text("Login"),
               buttonColor: Colors.amber,
             ),
             SizedBox(height: 20),
             RoundedButton(
                 child: Text("Register"),
                 onPressed: () => Navigator.pushNamed(context, Register1.id),
                 buttonColor: kPinkColor
             ),
             SizedBox(height: 5),
              RoundedButton(
                onPressed: () =>Navigator.pushNamed(context, ResetPassword.id),
                child: Text(
                  "Forget your Password?",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                buttonColor: Color(0xFF1A1843),
              ),
           ],
         ),
        ),
      )
    );
  }
}
