import 'package:flutter/material.dart';
import 'package:securezone/model/news_model.dart';
import 'package:securezone/model/report_model.dart';
import 'package:securezone/screens/reports_screen.dart';

class NewsItemWidget extends StatelessWidget {
  final Map<String, String> news;

  const NewsItemWidget({Key? key, required this.news}) : super(key: key);

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
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                     // Circular border radius for the title
                    child: Text(
                      news['title'] ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    news['description'] ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                            "Read More...",
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color.fromARGB(255, 103, 103, 103)),
                          ),
                ],
              ),
                  
                ],
              ),
        ),
      ),
    );
  }
}