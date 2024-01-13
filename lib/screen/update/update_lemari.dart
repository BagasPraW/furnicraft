import 'package:cloud_firestore/cloud_firestore.dart';
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

class UpdateLemari extends StatefulWidget {
  const UpdateLemari({Key? key}) : super(key: key);

  @override
  State<UpdateLemari> createState() => _UpdateLemariState();
}

class _UpdateLemariState extends State<UpdateLemari> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController id_lemariController = TextEditingController();
  final TextEditingController jenislemariController = TextEditingController();
  final TextEditingController stocklemariController = TextEditingController();
  final TextEditingController gambarlemariController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference lemari = firestore.collection('lemari');

    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    namaController.text = args['nama'];
    id_lemariController.text = args['id_lemari'];
    jenislemariController.text = args['jenis'];
    stocklemariController.text = args['stock'].toString();
    gambarlemariController.text = args['gambar'];
    String documentId = args['documentId'];

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Edit Lemari", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 20),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: namaController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Nama'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: id_lemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'ID Lemari'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: jenislemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Jenis'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: stocklemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: gambarlemariController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Gambar'),
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                colour: Color(0xFF35C2C1),
                title: 'Edit Data',
                onPressed: () {
                  lemari.doc(documentId).update({
                    'nama': namaController.text,
                    'id_lemari': id_lemariController.text,
                    'jenis': jenislemariController.text,
                    'stock': int.parse(stocklemariController.text),
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
