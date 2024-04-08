import 'package:flutter/material.dart';
import 'package:securezone/model/news_model.dart';
import 'package:securezone/model/report_model.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:securezone/widgets/news_item.dart';

class NewsScreen extends StatefulWidget {

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Map<String, String>> news = [];

  @override
  void initState(){
    super.initState();
    fetchReports();
  }

Future<void> fetchReports() async {
    // Call the fetchAllReports method from DBFunctions
    List<Map<String, String>> fetchedReports = await DBFunctions.fetchAllNews();
    // Update the state with the fetched reports
    setState(() {
      news = fetchedReports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text('News',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            final newsData = news[index];
            // if(newsData['type'] != 'Accident prone area' && newsData['type'] != 'Natural Disaster')
            return NewsItemWidget(news: newsData);
          },
        ),
      ),
    );
  }
}
