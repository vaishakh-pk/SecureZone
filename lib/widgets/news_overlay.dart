// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:url_launcher/url_launcher_string.dart';


class NewsOverlay extends StatefulWidget {
NewsOverlay({super.key,required this.report});

  Map<String, String> report;

  @override
  State<NewsOverlay> createState() => _NewsOverlayState();
}


class _NewsOverlayState extends State<NewsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.report["title"]!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.report["description"]!,
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
                if (widget.report['url'] != null) {
                  launchUrlString(widget.report['url'] ?? '');
                }
              },
              child: Text(
                "URL: ${widget.report['url'] ?? ''}",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: const Color.fromARGB(255, 13, 76, 127)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
