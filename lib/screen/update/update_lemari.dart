import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnicraft/utils/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  controller: id_lemariController,
                  decoration: const InputDecoration(hintText: 'ID lemari'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: jenislemariController,
                  decoration: const InputDecoration(hintText: 'Jenis'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: stocklemariController,
                  decoration: const InputDecoration(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: gambarlemariController,
                  decoration: const InputDecoration(hintText: 'Gambar'),
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
