import 'package:flutter/material.dart';
import 'package:securezone/screens/home.dart';
import 'package:securezone/screens/reports_screen.dart';

var knavbartheme = const Color.fromARGB(255, 201, 28, 28);


class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectpage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // void _setScreen(String identifier) async {
  //   Navigator.of(context).pop();

  //   if (identifier == 'filters') {
  //     final result = await Navigator.of(context)
  //         .push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilter: _selectedFilters,)));
  //   setState(() {
  //     _selectedFilters = result ?? kInitialFilters;
  //   });
     
  //   }
  // }

  //Build Logic

  @override
  Widget build(BuildContext context) {


    Widget activePage = HomeScreen();

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = ReportsScreen();
      activePageTitle = 'reports';
    }

    return Scaffold(
      appBar: AppBar(
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        selectedLabelStyle: TextStyle(color: Colors.black),
        showUnselectedLabels: true,
        // fixedColor: const Color.fromARGB(255, 197, 0, 0),
        unselectedItemColor: Colors.black,
        selectedItemColor: knavbartheme,
        iconSize: 30,
        items: [
          BottomNavigationBarItem( icon: Icon(Icons.home_outlined,color: knavbartheme), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_document,color: knavbartheme), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: knavbartheme),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper_outlined,color: knavbartheme,), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.settings,color: knavbartheme), label: 'Settings'),
        ],
        onTap: _selectpage,
      ),
    );
  }
}