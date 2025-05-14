import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:seminario_flutter/main.dart';

void main() {
  testWidgets('Tests that all home page widgets display correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.text('Characters'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsNWidgets(3));
  });
}
