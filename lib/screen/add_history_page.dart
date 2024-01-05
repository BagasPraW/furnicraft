// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class HistoryMeja {
//   String id_meja;
//   String jenis;
//   String nama;
//   var stock;
//   String status;

//   HistoryMeja({
//     required this.id_meja,
//     required this.jenis,
//     required this.nama,
//     required this.stock,
//     required this.status,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id_meja': id_meja,
//       'nama': nama,
//       'jenis': jenis,
//       'stock': stock,
//       'status': status,
//     };
//   }
// }

// class Historyservice {
//   final CollectionReference _HistoryCollection =
//       FirebaseFirestore.instance.collection('Meja');

//   // Variabel untuk menyimpan data stock sementara
//   int? _currentStock;

//   Future<int?> getStockById(String idMeja) async {
//     DocumentSnapshot snapshot = await _HistoryCollection.doc(idMeja).get();
//     if (snapshot.exists) {
//       // Simpan data stock sementara
//       _currentStock = snapshot.data()?['stock'];
//       return _currentStock;
//     } else {
//       return null; // Meja dengan ID tertentu tidak ditemukan
//     }
//   }

//   // Metode untuk mendapatkan data stock sementara
//   int? getCurrentStock() {
//     return _currentStock;
//   }

//   // Metode untuk menghapus data stock sementara
//   void clearCurrentStock() {
//     _currentStock = null;
//   }

//   Future<void> importHistoryFromCSV(BuildContext context) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['csv', 'xls', 'xlsx'],
//     );

//     if (result != null) {
//       PlatformFile file = result.files.first;
//       String csvString = utf8.decode(file.bytes!);
//       List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

//       for (List<dynamic> row in csvTable) {
//         String idMeja = row[0] as String; // Menggunakan nama field id_meja dari CSV
//         int quantityToAdd = row[3] as int; // Misalnya, CSV berisi id_meja di kolom pertama dan quantity di kolom keempat

//         // Ambil nilai stock dari Firebase
//         int? currentStock = await getStockById(idMeja);

//         if (currentStock != null) {
//           // Update nilai stock di Firebase dengan menambahkan nilai dari CSV
//           await _HistoryCollection.doc(idMeja).update({'stock': currentStock + quantityToAdd});
//         } else {
//           print('Error: Meja dengan ID $idMeja tidak ditemukan di Firebase.');
//         }
//       }

//       // Hapus data stock sementara setelah selesai mengimpor dari CSV
//       clearCurrentStock();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Data History berhasil diimpor.'),
//         ),
//       );
//     }
//   }

//   Future<void> deleteHistory(String DocumentId) async {
//     await _HistoryCollection.doc(DocumentId).delete();
//   }
// }
