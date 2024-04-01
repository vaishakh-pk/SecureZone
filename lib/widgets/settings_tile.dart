import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key,required this.titleText, required this.logo, this.passed});

  final IconData logo;
  final titleText;
  final Function()? passed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: knavbarselected,
                  leading: Icon(logo,color: knavbartheme,),
                  title: Text(titleText),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: passed,
                );
  }
}