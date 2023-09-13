import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/constants/date_formatter.dart';
import 'package:news_app/constants/theme.dart';

class NewsContainer extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final DateTime timestamp;

  const NewsContainer(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.source,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: Constant.height / 5,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: RichText(
                text: TextSpan(
                  text: "${timeAgo(timestamp)} ",
                  style: TextStyle(color: Colors.grey.shade400),
                  children: [
                    TextSpan(
                        text: source,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.blueAccent),
                ),
              ),
              trailing: imageUrl == ""
                  ? Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      width: Constant.width / 4.2,
                      height: Constant.height / 2,
                      decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                      ),
                      child: const Text(
                        "Unavailable",
                        style: AppTextStyles.body2MediumWhite,
                      ),
                    )
                  : Container(
                      width: Constant.width / 4.2,
                      height: Constant.height / 2,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: appTheme.primaryColorDark,
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
