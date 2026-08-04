import 'package:emotionsense_mobile/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the Material 3 foundation shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: EmotionSenseApp()));
    await tester.pumpAndSettle();

    expect(find.text('EmotionSense AI'), findsOneWidget);

    final context = tester.element(find.byType(Scaffold));
    expect(Theme.of(context).useMaterial3, isTrue);
  });
}
