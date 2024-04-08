import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:random_string/random_string.dart';

class DBFunctions {
  static double currentLat = 10;
  static double currentLong = 78;
  static List<Map<String, String>> allReports = [];
  static Future<String> getUser() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    
    final docSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId!)
          .get();
    final role = docSnapshot.data()?['role'];
    return role!;
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
        'lattitude': currentLat,
        'longitude': currentLong,
        'userID': userId,
        'isApproved': false,
        'timestamp': DateTime.now(),
        'reportId' : reportid
      });
    }
  }

  static Future<List<Map<String, String>>> fetchAllReports() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    List<Map<String, String>> reports = [];

    if (userId != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Reports').where('isApproved', isEqualTo: true).get();
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

  static Future<List<Map<String, String>>> unApprovedReports() async {
  List<Map<String, String>> reports = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('isApproved', isEqualTo: false)  // Filter reports based on userID
        .get();
    reports = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data()!;
      return data.map((key, value) => MapEntry(key, value.toString()));
    }).toList();

  return reports;
}

static Future<void> approveReport(String reportId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Reports')
          .doc(reportId)
          .update({'isApproved': true});
    } catch (e) {
      // Handle errors here
      print('Error approving report: $e');
    }
  }

static Future<void> deleteReport(String reportId) async {
    try {
      await FirebaseFirestore.instance.collection('Reports').doc(reportId).delete();
    } catch (e) {
      // Handle errors here
      print('Error deleting report: $e');
    }
  }

  static Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}


static Future<List<String>> fetchMessageConatcts() async {
  // Fetch the emergency message contacts from Firestore
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Emergency')
        .doc(userId)
        .collection('EmergencyMessage')
        .get();
    List<String> recipients = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data()!;
      return data['emergencyMessageNumber'].toString();
    }).toList();

    return Future.value(recipients);
  }

  // If the userId is null or any other error occurs, return an empty list
  return Future.value([]);
}

static Future<String> fetchCallContacts() async
{
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Emergency')
        .doc(userId)
        .get();
    String? emergencyCallNumber = snapshot.data()?['emergencyCallNumber'];

    return Future.value(emergencyCallNumber);
}
  return Future.value();
}

  static Future<List<Map<String, String>>> fetchAccidentReports() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  List<Map<String, String>> reports = [];

  if (userId != null) {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('type', isEqualTo: "Accident prone area").where('isApproved', isEqualTo: true)  // Filter reports based on userID
        .get();
    reports = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data()!;
      return data.map((key, value) => MapEntry(key, value.toString()));
    }).toList();
  }

  return reports;
}

  static Future<List<Map<String, String>>> fetchNaturalReports() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  List<Map<String, String>> reports = [];

  if (userId != null) {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('type', isEqualTo: "Natural Disaster").where('isApproved', isEqualTo: true)  // Filter reports based on userID
        .get();
    reports = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data()!;
      return data.map((key, value) => MapEntry(key, value.toString()));
    }).toList();
  }

  return reports;
}

  static Future<List<Map<String, String>>> fetchTheftReports() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  List<Map<String, String>> reports = [];

  if (userId != null) {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('type', isEqualTo: "Theft").where('isApproved', isEqualTo: true)  // Filter reports based on userID
        .get();
    reports = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data()!;
      return data.map((key, value) => MapEntry(key, value.toString()));
    }).toList();
  }

  return reports;
}

  static Future<List<Map<String, String>>> fetchMurderReports() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  List<Map<String, String>> reports = [];

  if (userId != null) {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('type', isEqualTo: "Murder").where('isApproved', isEqualTo: true)  // Filter reports based on userID
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