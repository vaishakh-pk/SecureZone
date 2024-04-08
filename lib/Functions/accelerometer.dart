import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AcccelerometerData extends StatefulWidget {
  @override
  _AcccelerometerDataState createState() => _AcccelerometerDataState();
}

class _AcccelerometerDataState extends State<AcccelerometerData> {
  late StreamSubscription _accelerometerSubscription;
  Map<String, double> _accelerometerValues = {'x': 0.0, 'y': 0.0, 'z': 0.0};

  @override
  void initState() {
    super.initState();
    // Subscribe to accelerometer data
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = {'x': event.x, 'y': event.y, 'z': event.z};
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
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
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 80),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _AxisValue(axis: 'X', value: _accelerometerValues['x'] ?? 0.0)),
            Expanded(child: _AxisValue(axis: 'Y', value: _accelerometerValues['y'] ?? 0.0)),
            Expanded(child: _AxisValue(axis: 'Z', value: _accelerometerValues['z'] ?? 0.0)),
          ],
        ),
      ),
    );
  }
}

class _AxisValue extends StatelessWidget {
  final String axis;
  final double value;

  const _AxisValue({required this.axis, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          axis,
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(height: 8),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}
