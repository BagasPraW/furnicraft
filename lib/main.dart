import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan_firebase/screen/page/login_page.dart';
import 'package:latihan_firebase/screen/page/register_page.dart';
import 'package:latihan_firebase/screen/page/welcome_page.dart';
import 'package:latihan_firebase/screen/page/home_page.dart';
import 'package:latihan_firebase/screen/page/forgot_password.dart';

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
      initialRoute: 'login_screen',
      home: LoginScreen(),
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        'reset_password': (context) => ForgotPasswordPage(),
      },
    );
  }
}
