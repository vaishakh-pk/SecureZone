import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10),
            child: Text('Settings',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 114,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: knavbarselected,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 66,
                        width: 66,
                        child: Icon(Icons.face,color: knavbartheme,size: 50,),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Super User', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                            Text('superuser@gmail.com', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                SettingsTile(titleText: 'Emergency Contact', logo: Icons.contact_emergency),
                const SizedBox(height: 20,),
                SettingsTile(titleText: 'SOS Settings', logo: Icons.sos),
                const SizedBox(height: 20,),
                SettingsTile(titleText: 'Crash Detection', logo: Icons.car_crash_sharp),
                const SizedBox(height: 20,),
                SettingsTile(titleText: 'privacy Settings', logo: Icons.privacy_tip_outlined),
                const SizedBox(height: 20,),
                SettingsTile(titleText: 'Logout', logo: Icons.close_rounded),
                
            ],),
          ),
        ),
      ),
    );
  }
}