import 'package:flutter/material.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReportItemWidget extends StatelessWidget {
  final Map<String, String> report;
  final String role;
  final Function(String) onApprove;
  final Function(String) onDelete;

  ReportItemWidget({
    Key? key,
    required this.report,
    required this.role,
    required this.onApprove,
    required this.onDelete,
  }) : super(key: key);

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Text(
                        report['title'] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Type: ${report['type'] ?? ''}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Description: ${report['description'] ?? ''}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 4.0),
                    InkWell(
                      
                      onTap: () { 
                        if(report['url'] != null)
                        {
                        launchUrlString(report['url'] ?? '');
                        }
                      }

                      ,
                      child: Text(
                        "URL: ${report['url'] ?? ''}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color.fromARGB(255, 13, 76, 127)),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
              // SizedBox(width: 10,),
              if(role == "super")
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      onApprove(report['reportId']!);
                    },
                    icon: Icon(Icons.check, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () {
                      onDelete(report['reportId']!);
                    },
                    icon: Icon(Icons.cancel, color: Colors.red),
                  )
                ]
          
              )
              else if(role == "user")
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right))
            ],
          ),
        ),
      ),
    );
  }
}
