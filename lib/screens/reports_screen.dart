import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:securezone/widgets/report_item.dart';
import 'package:securezone/services/DBServices.dart'; // Import DBFunctions

class ReportsScreen extends StatefulWidget {
  ReportsScreen({super.key, required this.role});

  String role;

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, String>> reports = [];

  @override
  void initState() {
    super.initState();
    // Fetch reports from Firebase when the screen initializes
    if (widget.role == "user") {
      fetchReports();
    } else if (widget.role == "super") {
      fetchUnapproved();
    }
  }

  Future<void> fetchReports() async {
    // Call the fetchAllReports method from DBFunctions
    List<Map<String, String>> fetchedReports = await DBFunctions.fetchUserReports();
    // Update the state with the fetched reports
    setState(() {
      reports = fetchedReports;
    });
  }

  Future<void> fetchUnapproved() async {
    // Call the fetchAllReports method from DBFunctions
    List<Map<String, String>> fetchedReports = await DBFunctions.unApprovedReports();
    // Update the state with the fetched reports
    setState(() {
      reports = fetchedReports;
    });
  }

  Future<void> approveReport(String reportId) async {
    if (reportId.isNotEmpty) {
      await DBFunctions.approveReport(reportId);
      // Refresh the reports list
      fetchUnapproved();
    }
  }

  Future<void> deleteReport(String reportId) async {
    if (reportId.isNotEmpty) {
      await DBFunctions.deleteReport(reportId);
      // Refresh the reports list
      fetchUnapproved();
    }
  }

  Future<void> deleteUserReport(String reportId) async {
    if (reportId.isNotEmpty) {
      await DBFunctions.deleteReport(reportId);
      // Refresh the reports list
      fetchReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Reports',
            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            return ReportItemWidget(
              report: report,
              role: widget.role,
              onApprove: (reportId) {
                // Call the approveReport method
                approveReport(reportId);
              },
              onDelete: (reportId) {
                // Call the deleteReport method
                deleteReport(reportId);
              },
              onUserDelete: (reportId)
              {
                deleteUserReport(reportId);
              }
            );
          },
        ),
      ),
    );
  }
}
