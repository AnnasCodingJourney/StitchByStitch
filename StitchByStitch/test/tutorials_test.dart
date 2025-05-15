// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';


// https://docs.flutter.dev/testing/overview
void main() {
  testWidgets('CircularProgressIndicator is displayed.', (WidgetTester tester) async {
    // Build a test widget with a CircularProgressIndicator
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CircularProgressIndicator(),
        ),
      ),
    );

    // Checks if the `CircularProgressIndicator` has been found.
    /*
      Because of the way I've coded this, I have no clue how to work around 
    */
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    print ("Circular Progess Indicator found successfully.");
  });
}