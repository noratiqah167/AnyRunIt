import 'package:anyrunit/auth/sign_in_screen/sign_in_page.dart';
import 'package:anyrunit/screens/cust_screen/home_screen/home_page.dart';
import 'package:anyrunit/screens/rider_screen/rhome_tab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:anyrunit/auth/authentication_service.dart';
import 'models/userModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await UserPreferences.init();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
        value: AuthenticationService().authStateChanges,

        // value: AuthenticationService.authStateChanges,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: SignInPage(),
            home: AuthenticationWrapper()));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = context.watch<Users>();
    final AuthenticationService _auth = AuthenticationService();
    final user = Provider.of<Users>(context);

    if (user != null) {
      return HomePage();
    }
    return SignInPage();
  }
}

class RiderWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationService _auth = AuthenticationService();
    final user = Provider.of<Users>(context);

    if (user == null) {
      return SignInPage();
    } else {
      // print(user.uid);
      return RHomeTab();
    }
  }
}
