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

class AddMeja extends StatefulWidget {
  const AddMeja({super.key});

  @override
  State<AddMeja> createState() => _AddMejaState();
}

class _AddMejaState extends State<AddMeja> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController id_mejaController = TextEditingController();
  final TextEditingController jenismejaController = TextEditingController();
  final TextEditingController stockmejaController = TextEditingController();
  final TextEditingController gambarmejaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference meja = firestore.collection('meja');

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
                  controller: id_mejaController,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ID Meja'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: jenismejaController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Jenis'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: stockmejaController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 56,
                child: TextField(
                  controller: gambarmejaController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Gambar'),
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                colour: Color(0xFF35C2C1),
                title: 'Tambah Data',
                onPressed: () {
                  meja.add({
                    'nama': namaController.text,
                    'id_meja': id_mejaController.text,
                    'jenis': jenismejaController.text,
                    'stock': stockmejaController.text,
                    'gambar': gambarmejaController.text,
                  });

                  namaController.text = '';
                  id_mejaController.text = '';
                  jenismejaController.text = '';
                  stockmejaController.text = '';
                  gambarmejaController.text = '';

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
