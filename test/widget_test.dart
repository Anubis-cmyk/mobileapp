// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobileapp/main.dart';

void main() {
  testWidgets('Test if the login page is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login page is displayed
    expect(find.text('Login'), findsOneWidget);
  });

testWidgets('Test if the list page is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the login button.
    await tester.tap(find.byIcon(Icons.login));
    await tester.pump();

    // Verify that the list page is displayed
    expect(find.text('List of Hotels'), findsOneWidget);
  });

  testWidgets('Test if the details page is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the login button.
    await tester.tap(find.byIcon(Icons.login));
    await tester.pump();

    // Tap the first item in the list
    await tester.tap(find.byIcon(Icons.hotel));
    await tester.pump();

    // Verify that the details page is displayed
    expect(find.text('Details'), findsOneWidget);
  });

testWidgets('Test if the details page is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the login button.
    await tester.tap(find.byIcon(Icons.login));
    await tester.pump();

    // Tap the first item in the list
    await tester.tap(find.byIcon(Icons.hotel));
    await tester.pump();

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();

    // Verify that the list page is displayed
    expect(find.text('List of Hotels'), findsOneWidget);
  });


}
