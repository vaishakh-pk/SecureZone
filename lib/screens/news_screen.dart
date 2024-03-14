import 'package:flutter/material.dart';
import 'package:securezone/model/news_model.dart';
import 'package:securezone/model/report_model.dart';
import 'package:securezone/widgets/news_item.dart';

class NewsScreen extends StatelessWidget {
  final List<NewsItem> news = [
    NewsItem("Title-1",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "),
    NewsItem("Title-2",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "),
    NewsItem("Title-3",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
    NewsItem("Title-4",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
  ];

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
            return NewsItemWidget(news: newsData);
          },
        ),
      ),
    );
  }
}
