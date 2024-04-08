import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/widgets/type_filter_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeFilterList extends StatefulWidget {
  TypeFilterList({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<TypeFilterList> createState() => _TypeFilterListState();
}

class _TypeFilterListState extends State<TypeFilterList> {
  String activeFilter = "All"; // Initialize active filter

  List<String> typesItems = ['All', 'Accident', 'Natural', 'Theft', 'Murder'];

  @override
  void initState() {
    super.initState();
    createInstance();
  }

  void createInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? prefFilter = prefs.getString('prefFilter');
    setState(() {
      activeFilter = prefFilter ?? 'All'; // Update active filter if stored value exists
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          for (final item in typesItems)
            TypeFilterItem(
              item: item,
              role: widget.role,
              activeFilter: activeFilter,
              onFilterSelected: (filter) {
                setState(() {
                  activeFilter = filter; // Update active filter
                });
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('prefFilter', filter); // Save selected filter
                });
                // Navigate or perform other actions based on the selected filter
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => TabsScreen(
                      role: widget.role,
                      filter: filter,
                    ),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
