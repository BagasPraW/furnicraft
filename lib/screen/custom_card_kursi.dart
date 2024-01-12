import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomCardKursi extends StatelessWidget {
  final String id_kursi;
  final String nama;
  final String jenis_kursi;
  final String stock_kursi;
  final String gambar_kursi;
  final String documentId;

  CustomCardKursi(this.id_kursi, this.nama, this.jenis_kursi, this.stock_kursi,
      this.gambar_kursi, this.documentId);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference kursi = firestore.collection('kursi');

    return Card(
      child: Container(
        width: 160,
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "$gambar_kursi",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text("$nama"),
              subtitle: Text("Stock : $stock_kursi"),
            ),
            Row(
              children: <Widget>[
                // Add a spacer to push the buttons to the right side of the card
                Spacer(),
                // Add a text button labeled "UBAH" with transparent foreground color and an accent color for the text
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    "UBAH",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {},
                ),
                // Add a text button labeled "HAPUS" with transparent foreground color and an accent color for the text
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    "HAPUS",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Warning"),
                          content: const Text("Remove this data?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                //Delete
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('REMOVE'),
                              onPressed: () {
                                kursi.doc(documentId).delete();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
