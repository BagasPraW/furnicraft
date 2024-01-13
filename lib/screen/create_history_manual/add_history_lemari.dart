import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class AddHistoryLemari extends StatefulWidget {
  const AddHistoryLemari({super.key});

  @override
  State<AddHistoryLemari> createState() => _AddHistoryLemariState();
}

class _AddHistoryLemariState extends State<AddHistoryLemari> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController id_historyController = TextEditingController();
  final TextEditingController id_lemariController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference history_lemari = firestore.collection('history_lemari');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "FURNICRAFT",
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 56,
                child: TextField(
                  controller: id_historyController,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ID History'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: id_lemariController,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ID Lemari'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: jumlahController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Jumlah'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: statusController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Status'),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                colour: Color(0xFF35C2C1),
                title: 'Tambah Data',
                onPressed: () {
                  history_lemari.add({
                    'id_history': id_historyController.text,
                    'id_lemari': id_lemariController.text,
                    'jumlah': jumlahController.text,
                    'status': statusController.text,
                  });

                  id_historyController.text = '';
                  id_lemariController.text = '';
                  jumlahController.text = '';
                  statusController.text = '';

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
