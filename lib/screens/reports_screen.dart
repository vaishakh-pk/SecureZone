import 'package:flutter/material.dart';
import 'package:securezone/model/report_model.dart';
import 'package:securezone/widgets/report_item.dart';



class ReportsScreen extends StatelessWidget {
  final List<ReportItem> reports = [
    ReportItem(
      "Title-1",
      "Type-1",
      "Location-1",
      "https://urll.com",
    ),
    ReportItem(
      "Title-2",
      "Type-2",
      "Location-2",
      "https://url2.com",
    ),
    ReportItem(
      "Title-3",
      "Type-3",
      "Location-3",
      "https://url3.com",
    ),
    ReportItem(
      "Title-4",
      "Type-4",
      "Location-4",
      "https://url4.com",
    ),
    ReportItem(
      "Title-5",
      "Type-5",
      "Location-5",
      "https://url4.com",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10),
            child: Text('Reports',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
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

