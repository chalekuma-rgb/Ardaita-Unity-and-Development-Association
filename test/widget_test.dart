import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:kecho/main.dart';

void main() {
  testWidgets('App renders main shell', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyTrendingWebApp());

    // Verify that the app bar title is shown.
    expect(find.text('Ardaita'), findsOneWidget);

    // Verify Home navigation item is visible.
    expect(find.text('Home'), findsOneWidget);
  });
}
