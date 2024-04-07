import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({Key? key}) : super(key: key);

  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  late int _timerValue;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Set the initial timer value (in seconds)
    _timerValue = 5;
    // Start the countdown timer
    _startTimer();
  }

  void _startTimer() {
    // Create a timer that runs every 1 second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Decrement the timer value
        _timerValue--;
        // Check if the timer has reached 0
        if (_timerValue <= 0) {
          // If timer runs out, initiate call
          _initiateCall();
          // Cancel the timer
          _timer.cancel();
        }
      });
    });
  }

  void _initiateCall() async {
    const phoneNumber = 'tel:119'; // Replace with your desired phone number
    try {
      // Use the newer approach to launch the phone app and make the call
      await launch(phoneNumber);
    } catch (e) {
      // Handle error: Unable to initiate call
      print('Error: Unable to initiate call');
    }
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
              SizedBox(height: 50,),
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
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {},
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
              SizedBox(height: 80),
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
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Cancel",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),),
                ),
              )
              ,
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
