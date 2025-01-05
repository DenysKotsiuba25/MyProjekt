import 'package:flutter/material.dart';
import 'news_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = ['business', 'entertainment', 'health', 'science', 'sports', 'technology'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(categories[index].toUpperCase()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewsListScreen(category: categories[index]),
              ));
            },
          );
        },
      ),
    );
  }
}
