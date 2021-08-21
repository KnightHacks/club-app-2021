import 'package:club_app_2021/screens/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/screens/register2.dart';
import 'package:club_app_2021/screens/accountview.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:club_app_2021/screens/faq.dart';
import 'package:club_app_2021/screens/confirm.dart';
import 'package:club_app_2021/screens/resetpassword.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await SentryFlutter.init(
    (options) => options.dsn = dotenv.env['SENTRY_DSN'],
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(), builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
      // Once complete, show your application
      if (snapshot.connectionState == ConnectionState.done) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            primaryColor: Color(0xFF1A1843),
            scaffoldBackgroundColor: Color(0xFF1A1843),
            accentColor: Color(0xFFb7517c),
            toggleableActiveColor: Color(0xFF36328B),
            cardColor: Color(0xFF36328B),
            //iconTheme: IconThemeData(color:  Color(0xFF1A1843)),
            //inactive color
          ),
          initialRoute: Login.id,
          routes: {
            Login.id: (context) => Login(),
            Register1.id: (context) => Register1(),
            Register2.id: (context) => Register2(),
            AccountView.id: (context) => AccountView(),
            AccountEdit.id: (context) => AccountEdit(),
            FAQ.id: (context) => FAQ(),
            Error.id: (context) => Error(),
            Confirm.id: (context) => Confirm(),
            ResetPassword.id: (context) => ResetPassword(),
            LoadingScreen.id: (context) => LoadingScreen(),
          },
        );
      }
      return Container();
    });
  }
}
