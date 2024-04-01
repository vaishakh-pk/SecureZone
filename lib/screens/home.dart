import 'package:flutter/material.dart';
import 'package:securezone/screens/map_screen.dart';
import 'package:securezone/screens/sos.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/widgets/search_bar.dart';
import 'package:securezone/widgets/type_filter_list.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: knavbartheme,
        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SOSScreen()));},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Text('SOS',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
      ),
      body: 
      Stack(children: [
        const MapScreen(),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SearchBarApp(),
              TypeFilterList(),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(left: 20,bottom: 15),
                alignment: Alignment.bottomLeft,
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          
                ),
                child: Text('Latest in Kochi',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
        
        ])
      );
  }
}
