import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:securezone/screens/emergency_contacts_screen.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({Key? key}) : super(key: key);

  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  late int _timerValue;
  late Timer _timer;

  late String emergencyCall;
  late List<String> emergencyMessage;

  @override
  void initState() {
    super.initState();
    // Set the initial timer value (in seconds)
    _timerValue = 5;
    fetchContacts();
    // Start the countdown timer
    _startTimer();
  }

  void fetchContacts() async {
    emergencyCall = await DBFunctions.fetchCallContacts();
    emergencyMessage = await DBFunctions.fetchMessageConatcts();
  }

  bool isPaused = false;

  void _startTimer() {
    // Create a timer that runs every 1 second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Decrement the timer value
        if (!isPaused) {
          _timerValue--;
          // Check if the timer has reached 0
          if (_timerValue <= 0) {
            // If timer runs out, initiate SMS sending
            _initiateSMS(emergencyMessage);
            _initiateCall(emergencyCall);
            // Cancel the timer
            _timer.cancel();
            Navigator.pop(context);
          }
        }
      });
    });
  }

  void _initiateCall(String emergencyCallNumber) async {
    if (emergencyCallNumber != null) {
      bool? res =
          await FlutterPhoneDirectCaller.callNumber(emergencyCallNumber);
      if (res != null && res) {
        // Call initiated successfully
        print('Call initiated successfully');
      } else {
        // Error occurred while initiating the call
        print('Error: Unable to initiate call');
      }
    }
  }

  void _initiateSMS(List<String> recipients) async {
    // Check if SMS permission is granted
    var status = await Permission.sms.request();
    if (status.isGranted) {
      // Permission granted, proceed with sending SMS
      try {
        String message = "This is An SOS Message !\n $customMessage";
        await sendSMS(
            message: message, recipients: recipients, sendDirect: true);
      } catch (e) {
        // Handle error: Unable to send SMS
        print('Error: Unable to send SMS');
      }
    } else {
      // Permission denied, handle accordingly
      print('SMS permission denied');
    }
  }

  TextEditingController _customMessageController = TextEditingController();

  String customMessage = '';

  _showApplyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(top: 300),
          child: AlertDialog(
            title: Text("Add Custom Message"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _customMessageController,
                  decoration: InputDecoration(labelText: 'Enter message !'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    isPaused = false;
                  });
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_customMessageController.text.isNotEmpty) {
                    setState(() {
                      customMessage = _customMessageController.text;
                      isPaused = false;
                    });

                    Navigator.pop(context);
                  }
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
    // Set initial values in the text fields
    _customMessageController.text = '';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 173, 36, 27),
              Colors.black,
            ],
            stops: [0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SOS',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 140,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  '$_timerValue',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                    onPressed: () {
                      _initiateCall("102");
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.local_hospital,
                        size: 50, color: Colors.white)),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {
                      _initiateCall("101");
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.fire_extinguisher,
                        size: 50, color: Colors.white)),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {
                      _initiateCall("100");
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.local_police,
                        size: 50, color: Colors.white)),
              ]),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPaused = true;
                  });
                  _showApplyDialog(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text(
                  'Custom Message',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
