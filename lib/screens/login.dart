import 'package:flutter/material.dart';
import '../widgets/login_form.dart';


class Login extends StatefulWidget {
  static const String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(child: Image.asset("assets/sword.png")),
              Expanded(child:
                SingleChildScrollView(child:
                  LoginForm()
                )
              ),
              // RoundedButton(
              //       child: Text("Register"),
              //       onPressed: (){
              //         Navigator.pushNamed(context, Register2.id);
              //       },
              //       buttonColor: Color(0xffdbc04a),
              // ),
            ],
          ),
        )
      ),
    );
  }
}