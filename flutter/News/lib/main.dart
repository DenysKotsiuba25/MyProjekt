import 'package:flutter/material.dart';
import 'package:newproject/screens/home_screen.dart';

void main() {
  runApp(const NewsFlashApp());
}

class NewsFlashApp extends StatelessWidget {
  const NewsFlashApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
