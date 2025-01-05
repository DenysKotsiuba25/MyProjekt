import 'package:flutter/material.dart';
import '../models/article.dart';
import '../screens/news_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: article.imageUrl.isNotEmpty
            ? Image.network(article.imageUrl, width: 50, fit: BoxFit.cover)
            : null,
        title: Text(article.title),
        subtitle: Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => NewsDetailScreen(article: article),
          ));
        },
      ),
    );
  }
}
