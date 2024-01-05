import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_Screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FurnitureHistoryPage());
}

class FurnitureHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Furniture History',
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ListTile(
                    title: Text(
                      'Create History Manually',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      // Add functionality for creating history manually
                    },
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ListTile(
                    title: Text(
                      'Create History by CSV',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      // Add functionality for creating history manually
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('kursi').snapshots(),
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<DataRow> rows = [];

              for (var document in documents) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                DataRow row = DataRow(cells: [
                  DataCell(Text(data['gambar'] ?? '')),
                  DataCell(Text(data['id_kursi']?.toString() ?? '')),
                  DataCell(Text(data['jenis']?.toString() ?? '')),
                  DataCell(Text(data['nama']?.toString() ?? '')),
                  DataCell(Text(data['stock']?.toString() ?? '')),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                ]);

                rows.add(row);
              }
              return DataTable(
                columns: [
                  DataColumn(label: Text('Gambar')),
                  DataColumn(label: Text('ID Kursi')),
                  DataColumn(label: Text('Jenis')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('AKSI')),
                ],
                rows: rows,
              );
            },
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('lemari').snapshots(),
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<DataRow> rows = [];

              for (var document in documents) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                DataRow row = DataRow(cells: [
                  DataCell(Text(data['gambar'] ?? '')),
                  DataCell(Text(data['id_lemari']?.toString() ?? '')),
                  DataCell(Text(data['jenis']?.toString() ?? '')),
                  DataCell(Text(data['nama']?.toString() ?? '')),
                  DataCell(Text(data['stock']?.toString() ?? '')),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                ]);

                rows.add(row);
              }
              return DataTable(
                columns: [
                  DataColumn(label: Text('Gambar')),
                  DataColumn(label: Text('ID Lemari')),
                  DataColumn(label: Text('Jenis')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('AKSI')),
                ],
                rows: rows,
              );
            },
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('meja').snapshots(),
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<DataRow> rows = [];

              for (var document in documents) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                DataRow row = DataRow(cells: [
                  DataCell(Text(data['gambar'] ?? '')),
                  DataCell(Text(data['id_meja']?.toString() ?? '')),
                  DataCell(Text(data['jenis']?.toString() ?? '')),
                  DataCell(Text(data['nama']?.toString() ?? '')),
                  DataCell(Text(data['stock']?.toString() ?? '')),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                ]);

                rows.add(row);
              }
              return DataTable(
                columns: [
                  DataColumn(label: Text('Gambar')),
                  DataColumn(label: Text('ID Meja')),
                  DataColumn(label: Text('Jenis')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('AKSI')),
                ],
                rows: rows,
              );
            },
          ),
        ],
      ),
    );
  }
}
