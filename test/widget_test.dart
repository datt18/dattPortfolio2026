import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dattpro/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: DattProApp()),
    );
    await tester.pump();
    // App should render without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
