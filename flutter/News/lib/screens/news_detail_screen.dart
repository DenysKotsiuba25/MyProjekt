import 'package:flutter/material.dart';
import '../models/article.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              Image.network(article.imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(article.title, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text(article.description),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
