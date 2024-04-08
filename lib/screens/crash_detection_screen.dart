import 'package:flutter/material.dart';
import 'package:securezone/Functions/accelerometer.dart';
import 'package:securezone/Functions/crash_detection.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/screens/test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrashDetectionScreen extends StatefulWidget {
  CrashDetectionScreen({super.key});

  @override
  State<CrashDetectionScreen> createState() => _CrashDetectionScreenState();
}

class _CrashDetectionScreenState extends State<CrashDetectionScreen> {
  bool light = true;

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
            if(light == true)
            Expanded(
              child: Column(
                children:[
              SpeedometerApp(),
              SizedBox(height: 40,),
              AcccelerometerData(),
              SizedBox(height: 100,),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrashTest()));}, child: Text("Test Crash Detection")))
                ]),
            )
            else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Turn on to user Crash detection services",style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: knavbartheme,
                        fontWeight: FontWeight.bold),),
                          ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
