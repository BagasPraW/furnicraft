import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HistoryMeja{
  String id_history;
  String id_meja;
  var jumlah;
  String status;

  HistoryMeja({
    required this.id_history,
    required this.id_meja,
    required this.jumlah,
    required this.status,

  });

  Map<String, dynamic> toMap(){
    return {
      'id_history' : id_history,
      'id_meja' : id_meja,
      'jumlah' : jumlah,
      'status' : status,
    };
  }

}
class HistoryMejaservice {
  final CollectionReference _HistoryMejaCollection =
  FirebaseFirestore.instance.collection('history_meja');

  Future<void> importHistoryMejaFromCSV(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );

    if (result != null){
      PlatformFile file = result.files.first;
      String csvString = utf8.decode(file.bytes!);
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

      for (List<dynamic> row in csvTable){
        HistoryMeja nilai = HistoryMeja(
          id_history: row[0] as String, 
          id_meja: row[1], 
          jumlah: row[2], 
          status: row[3]);

          await _HistoryMejaCollection.add(nilai.toMap());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data HistoryMeja berhasil di impor.'),
        )
      );
    }
  }
  Future<void> deleteHistoryMeja(String DocumentId) async {
    await _HistoryMejaCollection.doc(DocumentId).delete();
  }
}

class HistoryKursi{
  String id_history;
  String id_kursi;
  var jumlah;
  String status;

  HistoryKursi({
    required this.id_history,
    required this.id_kursi,
    required this.jumlah,
    required this.status,

  });

  Map<String, dynamic> toMap(){
    return {
      'id_history' : id_history,
      'id_kursi' : id_kursi,
      'jumlah' : jumlah,
      'status' : status,
    };
  }

}
class HistoryKursiservice {
  final CollectionReference _HistoryKursiCollection =
  FirebaseFirestore.instance.collection('history_kursi');

  Future<void> importHistoryKursiFromCSV(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );

    if (result != null){
      PlatformFile file = result.files.first;
      String csvString = utf8.decode(file.bytes!);
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

      for (List<dynamic> row in csvTable){
        HistoryKursi nilai = HistoryKursi(
          id_history: row[0] as String, 
          id_kursi: row[1], 
          jumlah: row[2], 
          status: row[3]);

          await _HistoryKursiCollection.add(nilai.toMap());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data HistoryKursi berhasil di impor.'),
        )
      );
    }
  }
  Future<void> deleteHistoryKursi(String DocumentId) async {
    await _HistoryKursiCollection.doc(DocumentId).delete();
  }
}

class HistoryLemari{
  String id_history;
  String id_lemari;
  var jumlah;
  String status;

  HistoryLemari({
    required this.id_history,
    required this.id_lemari,
    required this.jumlah,
    required this.status,

  });

  Map<String, dynamic> toMap(){
    return {
      'id_history' : id_history,
      'id_lemari' : id_lemari,
      'jumlah' : jumlah,
      'status' : status,
    };
  }

}

class HistoryLemariservice {
  final CollectionReference _HistoryLemariCollection =
  FirebaseFirestore.instance.collection('history_lemari');

  Future<void> importHistoryLemariFromCSV(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );

    if (result != null){
      PlatformFile file = result.files.first;
      String csvString = utf8.decode(file.bytes!);
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

      for (List<dynamic> row in csvTable){
        HistoryLemari nilai = HistoryLemari(
          id_history: row[0] as String, 
          id_lemari: row[1], 
          jumlah: row[2], 
          status: row[3]);

          await _HistoryLemariCollection.add(nilai.toMap());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data HistoryLemari berhasil di impor.'),
        )
      );
    }
  }
  Future<void> deleteHistoryLemari(String DocumentId) async {
    await _HistoryLemariCollection.doc(DocumentId).delete();
  }
}