import 'package:flutter/material.dart';
import 'package:securezone/screens/home.dart';
import 'package:securezone/screens/news_screen.dart';
import 'package:securezone/screens/reports_screen.dart';
import 'package:securezone/screens/settings_screen.dart';
import 'package:securezone/widgets/new_report.dart';

var knavbartheme = const Color.fromARGB(255, 201, 28, 28);

var knavbarselected = const Color.fromARGB(255, 255, 222, 222);

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
  var currentPageIndex = 0;

  void _openAddExpense()
  {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewReport();
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreen();

    if (currentPageIndex == 1) {
      activePage = ReportsScreen();
    } 
    else if(currentPageIndex == 2)
    {
      _openAddExpense();
    }
    else if (currentPageIndex == 3) {
      activePage = NewsScreen();
    } else if (currentPageIndex == 4) {
      activePage = SettingsScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: knavbarselected,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            // selectedIcon: Icon(Icons.home),
            icon: Icon(
              Icons.home,
              color: knavbartheme,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
                child: Icon(
              Icons.edit_document,
              color: knavbartheme,
            )),
            label: 'Reports',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.arrow_drop_down_circle,
              color: knavbartheme,
            ),
            icon: Icon(
              Icons.add_circle,
              color: knavbartheme,
            ),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(
                Icons.newspaper_outlined,
                color: knavbartheme,
              ),
            ),
            label: 'News',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
              color: knavbartheme,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
