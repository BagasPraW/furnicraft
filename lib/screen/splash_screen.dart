// ignore_for_file: unused_element

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:furnicraft/screen/user_auth/login_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
      // Timer untuk mengatur durasi tampilan splash screen
      Future.delayed(Duration(seconds: 3), () {
        // Pindah ke layar selanjutnya setelah tampilan splash selesai
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                LoginScreen(), // Ganti dengan halaman selanjutnya
          ),
        );
      });
    }

    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Image.asset('logo_furnicraft.png'),
            const Text(
              "FURNICRAFT",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0XFF35C2C1),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      nextScreen: LoginScreen(),
      splashIconSize: 250,
      duration: 300,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
