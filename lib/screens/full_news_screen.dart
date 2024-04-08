import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FullNews extends StatefulWidget {
  const FullNews({super.key, required this.news});

  final Map<String, String> news;
  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              widget.news['title']!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              widget.news['description']!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (widget.news['url'] != null) {
                  launchUrlString(widget.news['url'] ?? '');
                }
              },
              child: Text(
                "URL: ${widget.news['url'] ?? ''}",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: const Color.fromARGB(255, 13, 76, 127)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
