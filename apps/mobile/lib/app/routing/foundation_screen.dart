import 'package:flutter/material.dart';

class FoundationScreen extends StatelessWidget {
  const FoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Semantics(header: true, child: const Text('EmotionSense AI')),
      ),
    );
  }
}
