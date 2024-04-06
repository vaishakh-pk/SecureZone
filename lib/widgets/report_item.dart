// report_item.dart

import 'package:flutter/material.dart';

class ReportItemWidget extends StatelessWidget {
  final Map<String, String> report;

  const ReportItemWidget({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 255, 222, 222),
        ),
        margin: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Text(
                      report['title'] ?? '',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Type: ${report['type'] ?? ''}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Location: ${report['location'] ?? ''}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "URL: ${report['url'] ?? ''}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
              const Spacer(),
              Text(
                "Read More...",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Color.fromARGB(255, 103, 103, 103)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
