import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  String? verificationId;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber() async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await signInWithPhoneAuthCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (mounted) {
          setState(() {
            showErrorDialog(context, "Verification failed: ${e.message}");
          });
        }
      },
      codeSent: (String newVerificationId, int? resendToken) {
        verificationId = newVerificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  Future<void> signInWithPhoneAuthCredential(
      PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        // Add user to database with default role
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
          'uid': user.uid,
          'role': 'user' // Default role
          // Add other user details as needed
        });
      }
      // Retrieve the entire user document
      final docSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .get();

// Access the role field from the document data
      final role = docSnapshot.data()?['role'];

      if (role == "user") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TabsScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          showErrorDialog(context, "Invalid OTP: ${e.message}");
        });
      }
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecureZone'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                    labelText: 'Phone Number', border: InputBorder.none),
                keyboardType: TextInputType.phone,
                enabled: verificationId ==
                    null, // Disable phone number field after verification starts
              ),
            ),
            SizedBox(height: 10.0),
            if (verificationId != null)
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _otpController,
                  decoration: InputDecoration(labelText: 'Enter OTP'),
                ),
              ),
            SizedBox(height: 10.0),
            if (verificationId == null)
              ElevatedButton(
                onPressed: verificationId == null ? verifyPhoneNumber : null,
                child: Text('Send OTP'),
              ),
            if (verificationId != null)
              ElevatedButton(
                onPressed: () => signInWithPhoneAuthCredential(
                  PhoneAuthProvider.credential(
                    verificationId: verificationId!,
                    smsCode: _otpController.text,
                  ),
                ),
                child: Text('Submit OTP'),
              ),
          ],
        ),
      ),
    );
  }
}
