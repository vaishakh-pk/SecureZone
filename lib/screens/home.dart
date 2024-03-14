import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: knavbartheme,
        onPressed: () {},
        child: Text('SOS',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Home Screen')],
        ),
      ),
    );
  }
}
