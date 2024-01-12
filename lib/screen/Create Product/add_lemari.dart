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

class AddLemari extends StatefulWidget {
  const AddLemari({super.key});

  @override
  State<AddLemari> createState() => _AddLemariState();
}

class _AddLemariState extends State<AddLemari> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController id_lemariController = TextEditingController();
  final TextEditingController jenislemariController = TextEditingController();
  final TextEditingController stocklemariController = TextEditingController();
  final TextEditingController gambarlemariController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference lemari = firestore.collection('lemari');

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
                  controller: namaController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Nama'),
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
                  controller: jenislemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Jenis'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: stocklemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: gambarlemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Gambar'),
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                colour: Color(0xFF35C2C1),
                title: 'Tambah Data',
                onPressed: () {
                  lemari.add({
                    'nama': namaController.text,
                    'id_lemari': id_lemariController.text,
                    'jenis': jenislemariController.text,
                    'stock': stocklemariController.text,
                    'gambar': gambarlemariController.text,
                  });

                  namaController.text = '';
                  id_lemariController.text = '';
                  jenislemariController.text = '';
                  stocklemariController.text = '';
                  gambarlemariController.text = '';

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
