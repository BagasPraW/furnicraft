import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:furnicraft/screen/Update/update_kursi.dart';
import 'package:furnicraft/screen/Update/update_lemari.dart';
import 'package:furnicraft/screen/Update/update_meja.dart';
import 'package:furnicraft/screen/history/add_history_csv.dart';
import 'package:furnicraft/screen/furniture_list.dart';
import 'package:furnicraft/screen/splash_screen.dart';
import 'package:furnicraft/screen/user_auth/login_page.dart';
import 'package:furnicraft/screen/user_auth/register_page.dart';
import 'package:furnicraft/screen/welcome_page.dart';
import 'package:furnicraft/screen/home_screen.dart';
import 'package:furnicraft/screen/user_auth/forgot_password.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      home: SplashScreen(),
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        'reset_password': (context) => ForgotPasswordPage(),
        'add_history_csv': (context) => FurnitureHistoryPage(),
        'update_kursi': (context) => UpdateKursi(),
        'update_lemari': (context) => UpdateLemari(),
        'update_meja': (context) => UpdateMeja(),
      },
    );
  }
}
