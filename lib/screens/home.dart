import 'package:flutter/material.dart';
import 'package:securezone/screens/google_maps_screen.dart';
import 'package:securezone/screens/map_screen.dart';
import 'package:securezone/screens/sos.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:securezone/widgets/search_bar.dart';
import 'package:securezone/widgets/type_filter_list.dart';
class HomeScreen extends StatefulWidget {
HomeScreen({super.key, required this.role, this.filter});

  String role;
  String? filter;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>>? unApproved;
  int? unApprovedLen;

  void fetchUnapproved() async {
    unApproved = await DBFunctions.unApprovedReports();
    setState(() {
      unApprovedLen = unApproved!.length;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUnapproved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           GMapScreen(filter: widget.filter),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const SearchBarApp(),
                SizedBox(height: 30,),
                TypeFilterList(role: widget.role),
                const Spacer(),
                if (widget.role == "user")
                  Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 15),
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Latest in Kochi',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                else if (widget.role == "super")
                  Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 15),
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Waiting to be Approved : ${unApprovedLen ?? 0}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
