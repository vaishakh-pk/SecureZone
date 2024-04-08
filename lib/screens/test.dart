import 'dart:async';

import 'package:flutter/material.dart';
import 'package:securezone/Functions/accelerometer.dart';
import 'package:securezone/Functions/crash_detection.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/screens/test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatefulWidget {
  TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool light = true;
  double _currentSpeed = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createInstance();
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
    });

    index++;
    if (index >= dummySpeedData.length) {
      timer.cancel();
    }
  });
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
                  // This bool value toggles the switch.
                  value: light,
                  activeColor: knavbartheme,
                  onChanged: (bool value) {
                    print('Switch toggled');
                    setState(() {
                      light = value;
                      // Saving the updated value to SharedPreferences
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setBool('prefLight', light);
                      });
                    });
                  })
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
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            SpeedometerApp(),
            SizedBox(height: 40,),
            AcccelerometerData(),
            SizedBox(height: 100,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrashTest()));}, child: Text("Test Crash Detection")))
          ],
        ),
      ),
    );
  }
}
