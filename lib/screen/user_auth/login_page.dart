import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnicraft/screen/user_auth/forgot_password.dart';
import 'package:furnicraft/screen/user_auth/register_page.dart';
import 'package:furnicraft/utils/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

//code for designing the UI of our text field where the user writes his
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String? validatePassword(String value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Masukan Email dan Password yang benar';
    } else {
      return null;
    }
  }
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  String? passwordError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 120.0),
            child: Text(
              'Welcome back! Glad to see you, Again!',
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
              textAlign: TextAlign.left,
              onChanged: (value) {
                email = value;
                // Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.left,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password.',
              ),
              style: TextStyle(color: Colors.black),
            ),
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
            child: InkWell(
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: RoundedButton(
              colour: Color(0xFF35C2C1),
              title: 'Log In',
              onPressed: () async {
                setState(() {
                  passwordError = validatePassword(password);
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, 'home_screen');
                  }
                } catch (e) {
                  print(e);
                  String errorMessage = "Terjadi kesalahan saat login.";

                  if (e is FirebaseAuthException) {
                    switch (e.code) {
                      case 'user-not-found':
                        errorMessage =
                            'Akun tidak ditemukan. Silakan daftar terlebih dahulu.';
                        break;
                      case 'wrong-password':
                        errorMessage = 'Password salah. Periksa kembali.';
                        break;
                      // tambahkan case lain sesuai kebutuhan
                    }
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Login Gagal'),
                        content: Text(errorMessage),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
                setState(() {});
              },
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don’t have an account?',
                  style: GoogleFonts.urbanist(fontSize: 14.0),
                ),
                SizedBox(height: 16.0), // Spasi antara teks dan InkWell
                InkWell(
                    child: Text(
                      ' Register Now',
                      style: GoogleFonts.urbanist(color: Colors.blue),
                    ),
                    onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()),
                        )),
              ],
            ),
          )
         
        ],
      ),
    );
  }
}
