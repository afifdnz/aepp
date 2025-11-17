// views/dummy_screen.dart
import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {
  final String title;
  const DummyScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
