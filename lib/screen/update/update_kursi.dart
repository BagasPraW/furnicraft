import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnicraft/utils/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateKursi extends StatefulWidget {
  const UpdateKursi({Key? key}) : super(key: key);

  @override
  State<UpdateKursi> createState() => _UpdateKursiState();
}

class _UpdateKursiState extends State<UpdateKursi> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController id_kursiController = TextEditingController();
  final TextEditingController jeniskursiController = TextEditingController();
  final TextEditingController stockkursiController = TextEditingController();
  final TextEditingController gambarkursiController = TextEditingController();
  @override
  // String status = ;
  // int jumlahBarangMasuk = ;
  // int jumlahBarangKeluar = ;
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference kursi = firestore.collection('kursi');

    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    namaController.text = args['nama'];
    id_kursiController.text = args['id_kursi'];
    jeniskursiController.text = args['jenis'];
    stockkursiController.text = args['stock'].toString();
    gambarkursiController.text = args['gambar'];
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
                  controller: id_kursiController,
                  decoration: const InputDecoration(hintText: 'ID Kursi'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: jeniskursiController,
                  decoration: const InputDecoration(hintText: 'Jenis'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: stockkursiController,
                  decoration: const InputDecoration(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: gambarkursiController,
                  decoration: const InputDecoration(hintText: 'Gambar'),
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                colour: Color(0xFF35C2C1),
                title: 'Edit Data',
                onPressed: () {
                  kursi.doc(documentId).update({
                    'nama': namaController.text,
                    'id_kursi': id_kursiController.text,
                    'jenis': jeniskursiController.text,
                    'stock': int.parse(stockkursiController.text),
                    'gambar': gambarkursiController.text,
                  });

                  namaController.text = '';
                  id_kursiController.text = '';
                  jeniskursiController.text = '';
                  stockkursiController.text = '';
                  gambarkursiController.text = '';

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
