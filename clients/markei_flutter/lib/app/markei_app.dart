import 'package:flutter/material.dart';

class MarkeiApp extends StatelessWidget {
  const MarkeiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markei',
      theme: ThemeData(colorSchemeSeed: const Color(0xff246b5a)),
      home: const Scaffold(
        body: Center(child: Text('Markei shared client foundation')),
      ),
    );
  }
}
