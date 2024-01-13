import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnicraft/screen/history/add_history_csv.dart';
import 'home_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnicraft/screen/history/add_history_kursi.dart';
import 'package:furnicraft/screen/history/add_history_meja.dart';
import 'package:furnicraft/screen/history/add_history_lemari.dart';

void main() {
  runApp(FurnitureHistoryPage());
}

class FurnitureHistoryPage extends StatelessWidget {
  final HistoryMejaservice _historyMejaservice = HistoryMejaservice();
  final HistoryKursiservice _historyKursiservice = HistoryKursiservice();
  final HistoryLemariservice _historyLemariservice = HistoryLemariservice();

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ExpansionTile(
                          title: Text('Create History Manually'),
                          children: <Widget>[
                            Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: ListTile(
                                title: Text(
                                  'Create History Meja',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddHistoryMeja(),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: ListTile(
                                title: Text(
                                  'Create History Kursi',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddHistoryKursi(),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: ListTile(
                                title: Text(
                                  'Create History Lemari',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddHistoryLemari(),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: ExpansionTile(
                        title: Text('Import by CSV'),
                        children: <Widget>[
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                              title: Text(
                                'Import History Meja by CSV',
                                style: TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                // Add functionality for creating history manually
                                _historyMejaservice
                                    .importHistoryMejaFromCSV(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                              title: Text(
                                'Import History Kursi by CSV',
                                style: TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                // Add functionality for creating history manually
                                _historyKursiservice
                                    .importHistoryKursiFromCSV(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                              title: Text(
                                'Import History by CSV',
                                style: TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                // Add functionality for creating history manually
                                _historyLemariservice
                                    .importHistoryLemariFromCSV(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('history_meja')
                    .snapshots(),
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
                      DataCell(Text(data['id_history'] ?? '')),
                      DataCell(Text(data['id_meja']?.toString() ?? '')),
                      DataCell(Text(data['jumlah']?.toString() ?? '')),
                      DataCell(Text(data['status']?.toString() ?? '')),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _historyMejaservice.deleteHistoryMeja(document.id);
                          },
                        ),
                      ),
                    ]);

                    rows.add(row);
                  }
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('ID_History')),
                      DataColumn(label: Text('ID_Meja')),
                      DataColumn(label: Text('Jumlah')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('AKSI')),
                    ],
                    rows: rows,
                  );
                },
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('history_kursi')
                    .snapshots(),
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
                      DataCell(Text(data['id_history'] ?? '')),
                      DataCell(Text(data['id_kursi']?.toString() ?? '')),
                      DataCell(Text(data['jumlah']?.toString() ?? '')),
                      DataCell(Text(data['status']?.toString() ?? '')),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _historyKursiservice.deleteHistoryKursi(document.id);
                          },
                        ),
                      ),
                    ]);

                    rows.add(row);
                  }
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('ID_History')),
                      DataColumn(label: Text('ID_Kursi')),
                      DataColumn(label: Text('Jumlah')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('AKSI')),
                    ],
                    rows: rows,
                  );
                },
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('history_lemari')
                    .snapshots(),
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
                      DataCell(Text(data['id_history'] ?? '')),
                      DataCell(Text(data['id_lemari']?.toString() ?? '')),
                      DataCell(Text(data['jumlah']?.toString() ?? '')),
                      DataCell(Text(data['status']?.toString() ?? '')),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _historyLemariservice.deleteHistoryLemari(document.id);
                          },
                        ),
                      ),
                    ]);

                    rows.add(row);
                  }
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('ID_History')),
                      DataColumn(label: Text('ID_lemari')),
                      DataColumn(label: Text('Jumlah')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('AKSI')),
                    ],
                    rows: rows,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
