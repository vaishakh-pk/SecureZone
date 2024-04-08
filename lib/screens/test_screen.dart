import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:securezone/Functions/accelerometer.dart';
import 'package:securezone/screens/sos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrashTest extends StatefulWidget {
  CrashTest({super.key});

  @override
  State<CrashTest> createState() => _CrashTestState();
}

class _CrashTestState extends State<CrashTest> {
  bool light = true;
  double _currentSpeed = 0.0;
  double? _previousSpeed;
  bool isTriggered = false;

  @override
void initState() {
  super.initState();
  createInstance();
  generateDummyData(); // Generate dummy data when the screen loads
}


  void createInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? prefLight = prefs.getBool('prefLight');
    setState(() {
      light = prefLight!;
    });
  }

void generateDummyData() {
  const List<double> dummySpeedData = [
    20.0, 25.0, 30.0, 35.0, 40.0, // Increasing speed
    35.0, 30.0, 25.0, 20.0, 15.0, 10.0, 5.0, // Deceleration causing accident
    5.0, 5.0, 5.0, // Constant low speed after accident
  ];

  int index = 0;
  List<Duration> delays = [
    for (int i = 0; i < dummySpeedData.length; i++)
      Duration(milliseconds: i < 5 ? 1000 : 10) // Slower acceleration, faster deceleration
  ];

  Timer.periodic(delays[index], (timer) {
    setState(() {
      _currentSpeed = dummySpeedData[index];
      print("Current Speed: $_currentSpeed"); // Add this print statement
      if (_currentSpeed == 5 && isTriggered == false) {
      _updateSpeed(_currentSpeed);
      isTriggered = true;
    }
    });

    index++;
    if (index >= dummySpeedData.length) {
      timer.cancel();
    }
  });
}




void _updateSpeed(double speed) {
  setState(() {
    _currentSpeed = speed;
    if (_currentSpeed == 5) {
      // Speed has reached 5, trigger handleDeceleration
      _handleSuddenDeceleration();
    }
  });
}



  void _handleSuddenDeceleration() {
    // Perform actions here when sudden deceleration is detected
    print('Sudden deceleration detected!');
    // Navigate to a different page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SOSScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Row(
            children: [
              Text(
                'Crash Detection',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Switch(
                value: light,
                activeColor: Colors.blue, // Use your desired color
                onChanged: (bool value) {
                  setState(() {
                    light = value;
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setBool('prefLight', light);
                    });
                  });
                },
              )
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
              "Note: This is an approximate calculation, actual incident may differ. Timer of 10 sec has been enabled to handle accidental triggers.",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 40),
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 25),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Text(
                  'Current Speed: ${_currentSpeed.toStringAsFixed(2)} m/s',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            SizedBox(height: 40),
            AcccelerometerData(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
