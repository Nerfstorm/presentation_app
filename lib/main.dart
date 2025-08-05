import 'package:flutter/material.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Portfolio'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Welcome to my portfolio!\n\nStart customizing this page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
