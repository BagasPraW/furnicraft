import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomCardMeja extends StatelessWidget {
  final String id_meja;
  final String nama;
  final String jenis;
  final int stock;
  final String gambar;
  final String documentId;

  CustomCardMeja(this.id_meja, this.nama, this.jenis, this.stock, this.gambar,
      this.documentId);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference meja = firestore.collection('meja');
    return Card(
      child: Container(
        width: 160,
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "$gambar",
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text("$nama"),
              subtitle: Text("Stock : $stock"),
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
                  onPressed: () {
                    Navigator.pushNamed(context, 'update_meja', arguments: {
                      'nama': nama,
                      'id_meja': id_meja,
                      'jenis': jenis,
                      'stock': stock,
                      'gambar': gambar,
                      'documentId': documentId,
                    });
                  },
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
                                meja.doc(documentId).delete();
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
