import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplySuperUserScreen extends StatefulWidget {
  ApplySuperUserScreen({super.key});

  @override
  State<ApplySuperUserScreen> createState() => _ApplySuperUserScreenState();
}

class _ApplySuperUserScreenState extends State<ApplySuperUserScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _organistionController = TextEditingController();

  _showApplyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _organistionController,
                decoration: InputDecoration(labelText: 'Organisation Name'),
                keyboardType: TextInputType.text,
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
                    _organistionController.text.isNotEmpty) {
                  _launchEmail(_nameController.text,_organistionController.text);
                }
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
    // Set initial values in the text fields
    _nameController.text =  '';
    _organistionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Row(
            children: [
              Text(
                'Apply for SuperUser',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note: Apply through email by attatching the documents listed below",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "- Registration document of community / organisation",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "- Copy of Aadhar of authorized personnel",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Spacer(),
            InkWell(
              onTap: () {
                _showApplyDialog(context);
              },
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
                    child: Text("Apply Now",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_launchEmail(String name, String organisation) async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'securezone79@gmail.com', // Add your recipient email here
    queryParameters: {
      'subject': 'Applying for SuperUser - uid: $userId',
      'body':
          'Dear Sir/Madam,\n\nI am writing to apply for SuperUser status in your application.\n\nName: $name\n- Name of Organisation : $organisation\nThank you.\n\nSincerely,\n$name'
    },
  );

  String url = params.toString().replaceAll('+', '%20');
  try {
    await launch(url);
  } catch (e) {
    print("Error launching email: $e");
  }
}

