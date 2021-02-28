import 'package:flutter/material.dart';

class LoginContainer extends StatefulWidget {
  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
                  labelText: "Username"
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Password"
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
          )
        ],
      ),
    );
  }
}
