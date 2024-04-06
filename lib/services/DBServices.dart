import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class DBFunctions
{

  Future<String> getUser() async
  {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return userId!;
  }
  
  static Future<void> addNewReport(TextEditingController _titleController,TextEditingController _descriptionController,TextEditingController _typeController,TextEditingController _yearController,TextEditingController _urlController,TextEditingController _locationController,) async
  {

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
        // 'location': _locationController.text,
        'userID' : userId,
        'isApproved' : false
      });
  }


}
}