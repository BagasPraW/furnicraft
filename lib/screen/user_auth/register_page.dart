

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnicraft/screen/user_auth/login_page.dart';
import 'package:furnicraft/utils/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a Value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
  border: OutlineInputBorder(), // Hapus borderRadius di sini
  // fillColor: Color(0xFFEEF5FC),
  // filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    // Hapus borderRadius di sini
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEEF5FC), width: 32.0),
    // Hapus borderRadius di sini
  ),
);

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

String? validatePassword(String value) {
  RegExp uppercaseRegex = RegExp(r'(?=.*?[A-Z])');
  RegExp lowercaseRegex = RegExp(r'(?=.*?[a-z])');
  RegExp digitRegex = RegExp(r'(?=.*?[0-9])');
  RegExp specialCharRegex = RegExp(r'(?=.*?[!@#\$&*~])');

  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    String message = 'Masukan Password yang Sesusai:';

    if (!uppercaseRegex.hasMatch(value)) {
      message += '\n- Setidaknya satu huruf besar (A-Z)';
    }

    if (!lowercaseRegex.hasMatch(value)) {
      message += '\n- Setidaknya satu huruf kecil (a-z)';
    }

    if (!digitRegex.hasMatch(value)) {
      message += '\n- Setidaknya satu angka (0-9)';
    }

    if (!specialCharRegex.hasMatch(value)) {
      message += '\n- Setidaknya satu karakter khusus (!@#\$&*~)';
    }

    if (value.length < 8) {
      message += '\n- Minimal 8 karakter';
    }

    // Jika semua kriteria terpenuhi, kembalikan null (tidak ada pesan kesalahan)
    return message == 'Masukan Password yang Sesusai:' ? null : message;
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 100.0),
            child: Text(
              'Hello! Register to get started',
              style: GoogleFonts.urbanist(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
                style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password'),
                style: TextStyle(color: Colors.black)),
          ),
          SizedBox(
            height: 24.0,
          ),
          if (passwordError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                passwordError!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: RoundedButton(
              colour: Color(0xFF35C2C1),
              title: 'Register',
              onPressed: () async {
                setState(() {
                  passwordError = validatePassword(password);
                });

                if (passwordError == null) {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser != null) {
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    print(e);
                    // Handle error creating user in Firebase Authentication
                  }
                }
                setState(() {});
              },
            ),
          ),
         
        ],
      ),
    );
  }
}
