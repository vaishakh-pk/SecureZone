import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:random_string/random_string.dart';

class DBFunctions {
  static GeoPoint currentLoc = GeoPoint(10, 25);
  static List<Map<String, String>> allReports = [];
  Future<String> getUser() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return userId!;
  }

  static Future<void> addNewReport(
    TextEditingController _titleController,
    TextEditingController _descriptionController,
    TextEditingController _typeController,
    TextEditingController _yearController,
    TextEditingController _urlController,
    TextEditingController _locationController,
  ) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    String reportid = randomAlphaNumeric(10);

    if (userId != null) {
      // Save or update emergency contact details to Firestore
      await FirebaseFirestore.instance.collection('Reports').doc(reportid).set({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'type': _typeController.text,
        'year': _yearController.text,
        'url': _urlController.text,
        'location': GeoPoint(10.0452, 76.3267),
        'userID': userId,
        'isApproved': false,
        'timestamp': DateTime.now()
      });
    }
  }

  static Future<List<Map<String, String>>> fetchAllReports() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    List<Map<String, String>> reports = [];

    if (userId != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Reports').get();
      reports = snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data()!;
        return data.map((key, value) => MapEntry(key, value.toString()));
      }).toList();
    }

    return reports;
  }

  static Future<List<Map<String, String>>> fetchUserReports() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  List<Map<String, String>> reports = [];

  if (userId != null) {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('userID', isEqualTo: userId)  // Filter reports based on userID
        .get();
    reports = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data()!;
      return data.map((key, value) => MapEntry(key, value.toString()));
    }).toList();
  }

  return reports;
}



Map<String, String> _convertDynamicMapToStringMap(Map<String, dynamic> data) {
  return data.map((key, value) => MapEntry(key, value.toString()));
}
}