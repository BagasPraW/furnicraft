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
    // final kursi_history = FirebaseFirestore.instance.collection("history_kursi").doc(id_kursiController.text);
    // int jumlahBarangMasuk = 0;
    // int jumlahBarangKeluar = 0;
    // String status = '';

    // DocumentSnapshot kursiSnapshot = await kursi_history.get();
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
              Text("Edit Kursi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                  controller: id_kursiController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'ID Kursi'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: jeniskursiController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Jenis'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: stockkursiController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: gambarkursiController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Gambar'),
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
