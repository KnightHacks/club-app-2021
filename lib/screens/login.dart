import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: SafeArea(
        child: Column(
          // This is a place holder
          children: [
            RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/Register1");
                },
                child: Text("Go to Screen 1"),
              ),
            RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/Register2");
                },
                child: Text("Go to Screen 1"),
              ),
            RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/Home");
                },
                child: Text("Go to Screen 1"),
              ),
            RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/AccountView");
                },
                child: Text("Go to Screen 1"),
              ),
            RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/AccountEdit");
                },
                child: Text("Go to Screen 1"),
              ),
          ],
        )
      ),
    );
  }
}