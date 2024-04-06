import 'package:flutter/material.dart';
import 'package:securezone/screens/home.dart';
import 'package:securezone/screens/news_screen.dart';
import 'package:securezone/screens/reports_screen.dart';
import 'package:securezone/screens/settings_screen.dart';
import 'package:securezone/screens/sos.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:securezone/widgets/new_report.dart';

var knavbartheme = const Color.fromARGB(255, 201, 28, 28);

var knavbarselected = const Color.fromARGB(255, 255, 222, 222);

class TabsScreen extends StatefulWidget {
 TabsScreen({super.key, required this.role});

  String role;
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

  void _openAddReportOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (ctx) {
          return NewReport();
        }).then((value){
          setState(() {
            currentPageIndex = 0;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    // Widget activePage = HomeScreen();
     Widget activePage = HomeScreen(role: widget.role);
  
    if (currentPageIndex == 1) {
      activePage = ReportsScreen(role: widget.role,);
    } else if (currentPageIndex == 2) {
      // Schedule the modal sheet to open after the build process is complete.
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ModalRoute.of(context)!.isCurrent) {
                // This check ensures the callback does not run if the user navigates away from the current route
                // before the callback is executed.
                return;
            }
            _openAddReportOverlay();
        });
    } else if (currentPageIndex == 3) {
      activePage = NewsScreen();
    } else if (currentPageIndex == 4) {
      activePage = SettingsScreen();
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        elevation: 10,
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
      body: activePage,
    );
  }
}
