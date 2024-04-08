import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _newMessageNameController = TextEditingController();
  TextEditingController _newMessageNumberController = TextEditingController();
  TextEditingController _editMessageNameController = TextEditingController();
  TextEditingController _editMessageNumberController = TextEditingController();

  String? _name;
  String? _phoneNumber;
  List<Map<String, String>> _emergencyMessageContacts = [];

  @override
  void initState() {
    super.initState();
    // Fetch emergency contact details from Firestore
    fetchEmergencyContactDetails();
    // Fetch emergency message contacts from Firestore
    fetchEmergencyMessageContacts();
  }

  void fetchEmergencyContactDetails() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Emergency')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        setState(() {
          _name = snapshot.data()?['emergencyCallName'];
          _phoneNumber = snapshot.data()?['emergencyCallNumber'];
        });
      }
    }
  }

  void fetchEmergencyMessageContacts() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Emergency')
          .doc(userId)
          .collection('EmergencyMessage')
          .get();
      List<Map<String, String>> contacts = snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data()!;
        return _convertDynamicMapToStringMap(data);
      }).toList();
      setState(() {
        _emergencyMessageContacts = contacts;
      });
    }
  }

  Map<String, String> _convertDynamicMapToStringMap(Map<String, dynamic> data) {
    return data.map((key, value) => MapEntry(key, value.toString()));
  }

  void saveEmergencyContactDetails() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Save or update emergency contact details to Firestore
      await FirebaseFirestore.instance.collection('Emergency').doc(userId).set({
        'emergencyCallName': _nameController.text,
        'emergencyCallNumber': _phoneNumberController.text,
      });
      setState(() {
        _name = _nameController.text;
        _phoneNumber = _phoneNumberController.text;
      });
    }
  }

  void saveNewEmergencyMessageContact() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Save new emergency message contact to Firestore
      await FirebaseFirestore.instance
          .collection('Emergency')
          .doc(userId)
          .collection('EmergencyMessage')
          .add({
        'emergencyMessageName': _newMessageNameController.text,
        'emergencyMessageNumber': _newMessageNumberController.text,
      });
      fetchEmergencyMessageContacts(); // Refresh the list of emergency message contacts
    }
  }

  void saveEditedEmergencyMessageContact(Map<String, String> contact) async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Get the document ID of the contact
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Emergency')
          .doc(userId)
          .collection('EmergencyMessage')
          .where('emergencyMessageName',
              isEqualTo: contact['emergencyMessageName'])
          .where('emergencyMessageNumber',
              isEqualTo: contact['emergencyMessageNumber'])
          .get();
      String docId = snapshot.docs.first.id;
      // Update the existing emergency message contact in Firestore
      await FirebaseFirestore.instance
          .collection('Emergency')
          .doc(userId)
          .collection('EmergencyMessage')
          .doc(docId)
          .update({
        'emergencyMessageName': _editMessageNameController.text,
        'emergencyMessageNumber': _editMessageNumberController.text,
      });
      fetchEmergencyMessageContacts(); // Refresh the list of emergency message contacts
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Emergency Contacts',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Emergency call",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if(_name == null && _phoneNumber == null)
                
              InkWell(
                onTap: () async {
          final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
          setState(() {
            _nameController.text = contact.fullName.toString();
            _phoneNumberController.text =contact.phoneNumber!.number.toString();
          });
          saveEmergencyContactDetails();
        }
                ,
                child: Material(
                  color: Colors.redAccent,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Add more Contacts",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center)),
                ),
              )
              else
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                                  _name!,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              // Get the current user's ID
                              String? userId =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (userId != null) {
                                // Delete the emergency call contact from Firestore
                                await FirebaseFirestore.instance
                                    .collection('Emergency')
                                    .doc(userId)
                                    .delete();
                                // Clear the local variables
                                setState(() {
                                  _name = null;
                                  _phoneNumber = null;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Edit Contact"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                              labelText: 'Name'),
                                        ),
                                        TextField(
                                          controller: _phoneNumberController,
                                          decoration: InputDecoration(
                                              labelText: 'Phone Number'),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_nameController.text.isNotEmpty &&
                                              _phoneNumberController
                                                  .text.isNotEmpty) {
                                            saveEmergencyContactDetails();
                                          }
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              // Set initial values in the text fields
                              _nameController.text = _name ?? '';
                              _phoneNumberController.text = _phoneNumber ?? '';
                            },
                          ),
                        ],
                      ),
                      _phoneNumber != null
                          ? Text(
                              _phoneNumber!,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text('None', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Emergency Message",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              for (var contact in _emergencyMessageContacts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                contact['emergencyMessageName'] ?? "",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {
                                  // Get the current user's ID
                                  String? userId =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  if (userId != null) {
                                    // Get the document ID of the contact
                                    QuerySnapshot<Map<String, dynamic>>
                                        snapshot = await FirebaseFirestore
                                            .instance
                                            .collection('Emergency')
                                            .doc(userId)
                                            .collection('EmergencyMessage')
                                            .where('emergencyMessageName',
                                                isEqualTo: contact[
                                                    'emergencyMessageName'])
                                            .where('emergencyMessageNumber',
                                                isEqualTo: contact[
                                                    'emergencyMessageNumber'])
                                            .get();
                                    String docId = snapshot.docs.first.id;
                                    // Delete the emergency message contact from Firestore
                                    await FirebaseFirestore.instance
                                        .collection('Emergency')
                                        .doc(userId)
                                        .collection('EmergencyMessage')
                                        .doc(docId)
                                        .delete();
                                    // Refresh the list of emergency message contacts
                                    fetchEmergencyMessageContacts();
                                  }
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.redAccent),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Edit Emergency Message Contact"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller:
                                                  _editMessageNameController,
                                              decoration: InputDecoration(
                                                  labelText: 'Name'),
                                            ),
                                            TextField(
                                              controller:
                                                  _editMessageNumberController,
                                              decoration: InputDecoration(
                                                  labelText: 'Phone Number'),
                                              keyboardType: TextInputType.phone,
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (_editMessageNameController
                                                      .text.isNotEmpty &&
                                                  _editMessageNumberController
                                                      .text.isNotEmpty) {
                                                saveEditedEmergencyMessageContact(
                                                    contact);
                                              }
                                            },
                                            child: Text('Save'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  // Set initial values in the text fields
                                  _editMessageNameController.text =
                                      contact['emergencyMessageName'] ?? '';
                                  _editMessageNumberController.text =
                                      contact['emergencyMessageNumber'] ?? '';
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            contact['emergencyMessageNumber'] ?? "",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
          final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
          setState(() {
            _newMessageNameController.text = contact.fullName.toString();
            _newMessageNumberController.text =contact.phoneNumber!.number.toString();
          });
          saveNewEmergencyMessageContact();
          setState(() {
            _newMessageNameController.text =  '';
            _newMessageNumberController.text = '';
          });
        }
                ,
                child: Material(
                  color: Colors.redAccent,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Add more Contacts",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
