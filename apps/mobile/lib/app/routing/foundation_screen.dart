import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoundationScreen extends StatelessWidget {
  const FoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(header: true, child: const Text('EmotionSense AI')),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/camera'),
              child: const Text('Set up camera'),
            ),
          ],
        ),
      ),
    );
  }
}
