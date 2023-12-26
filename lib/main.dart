import 'package:flutter/material.dart';
import 'package:furnicraft/screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'we healthy',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home_screen',
      routes: {
        'home_screen': (context) => HomeScreen(),
        
      },
    );
  }
}
