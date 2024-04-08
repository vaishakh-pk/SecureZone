import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class SpeedometerApp extends StatefulWidget {
  const SpeedometerApp({Key? key}) : super(key: key);

  @override
  _SpeedometerAppState createState() => _SpeedometerAppState();
}

class _SpeedometerAppState extends State<SpeedometerApp> {
  double _currentSpeed = 0.0;
  double? _previousSpeed;
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        _updateSpeed(position.speed);
      },
    );
  }

  void _updateSpeed(double? speed) {
    if (speed != null) {
      setState(() {
        _previousSpeed ??= speed;
        if (_previousSpeed! - speed > 5) {
          // Sudden deceleration detected, take necessary action
          _handleSuddenDeceleration();
        }
        _currentSpeed = speed;
      });
    }
  }

  void _handleSuddenDeceleration() {
    // Perform actions here when sudden deceleration is detected
    print('Sudden deceleration detected!');
    // For example, you could trigger an alert, log the event, or notify emergency services.
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Container(
        alignment:Alignment.centerLeft,
        padding: EdgeInsets.only(left: 25),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
        ),
        child: 
          Text(
            'Current Speed: ${_currentSpeed.toStringAsFixed(2)} m/s',
            style: TextStyle(fontSize: 24.0),
          ),
          // Add the Speedometer widget here using the current speed (_currentSpeed)
        
      ),
    );
  }
}
