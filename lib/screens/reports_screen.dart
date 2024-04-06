// reports_screen.dart

import 'package:flutter/material.dart';
import 'package:securezone/widgets/report_item.dart';
import 'package:securezone/services/DBServices.dart'; // Import DBFunctions

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, String>> reports = [];

  @override
  void initState(){
    super.initState();
    // Fetch reports from Firebase when the screen initializes
    fetchReports();
  }

Future<void> fetchReports() async {
    // Call the fetchAllReports method from DBFunctions
    List<Map<String, String>> fetchedReports = await DBFunctions.fetchUserReports();
    // Update the state with the fetched reports
    setState(() {
      reports = fetchedReports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text('Reports', style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            return ReportItemWidget(report: report);
          },
        ),
      ),
    );
  }
}
