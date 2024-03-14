import 'package:flutter/material.dart';
import 'package:securezone/model/report_model.dart';
import 'package:securezone/screens/reports_screen.dart';

class ReportItemWidget extends StatelessWidget {
  final ReportItem report;

  const ReportItemWidget({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(20.0), // Adjust the border radius as needed
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 255, 222, 222),
        ),
        margin:
            const EdgeInsets.all(10.0), // Add some margin for spacing between items
        // Background color of the curved container
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20.0), // Circular border radius for the title
                    child: Text(
                      report.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Type: ${report.type}",
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Location: ${report.location}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "URL: ${report.url}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
              const Spacer(),
              Text(
                        "Read More...",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color.fromARGB(255, 103, 103, 103)),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}