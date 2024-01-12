import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnicraft/utils/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateMeja extends StatefulWidget {
  const UpdateMeja({Key? key}) : super(key: key);

  @override
  State<UpdateMeja> createState() => _UpdateMejaState();
}

class _UpdateMejaState extends State<UpdateMeja> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController id_mejaController = TextEditingController();
  final TextEditingController jenismejaController = TextEditingController();
  final TextEditingController stockmejaController = TextEditingController();
  final TextEditingController gambarmejaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference meja = firestore.collection('meja');

    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    namaController.text = args['nama'];
    id_mejaController.text = args['id_meja'];
    jenismejaController.text = args['jenis'];
    stockmejaController.text = args['stock'].toString();
    gambarmejaController.text = args['gambar'];
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
              SizedBox(
                height: 56,
                child: TextField(
                  controller: namaController,
                  decoration: const InputDecoration(hintText: 'Nama'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: id_mejaController,
                  decoration: const InputDecoration(hintText: 'ID meja'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: jenismejaController,
                  decoration: const InputDecoration(hintText: 'Jenis'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: stockmejaController,
                  decoration: const InputDecoration(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: gambarmejaController,
                  decoration: const InputDecoration(hintText: 'Gambar'),
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                colour: Color(0xFF35C2C1),
                title: 'Edit Data',
                onPressed: () {
                  meja.doc(documentId).update({
                    'nama': namaController.text,
                    'id_meja': id_mejaController.text,
                    'jenis': jenismejaController.text,
                    'stock': int.parse(stockmejaController.text),
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
