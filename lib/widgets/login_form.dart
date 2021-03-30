import 'package:club_app_2021/constants.dart';
import 'package:club_app_2021/screens/loading_screen.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/resetpassword.dart';

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
    if (!EmailValidator.validate(value) && (value.contains(knightsEmail) || value.contains(ucfEmail))) {
      return "Please enter valid knights email";
    }
    return null;
  };

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

      // Grabbing user info and putting in KhUser object.
      FirebaseUser user = res.user;
     
        if (user.isEmailVerified) {
          Navigator.popAndPushNamed(context, LoadingScreen.id);
        } else {
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
                   // Navigator.of(context, rootNavigator: true).pop('dialog');
                   Navigator.popAndPushNamed(context, LoadingScreen.id);
                 })
                 .catchError((err) {
                   print(err.toString());
                   // Navigator.of(context, rootNavigator: true).pop('dialog');
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
