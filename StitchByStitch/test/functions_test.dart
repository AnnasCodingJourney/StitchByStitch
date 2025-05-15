// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/event_data.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// https://docs.flutter.dev/testing/overview
void main() {

  testWidgets('CustomBottomNavigationBar tested and responds to taps', (WidgetTester tester) async {
    print("Test started");

    int tappedIndex = -1; // Initialised to a variable that isn't in the Navbar to see what item is tapped

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => EventData()),
          ChangeNotifierProvider(create: (context) => NotificationData()),
        ],
        child: MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CustomBottomNavigationBar(
              currentPageIndex: 0,
              onTap: (index) {
                tappedIndex = index;
                print("Tapped index: $index"); // Prints out when the NavBar is tapped
              },
            ),
          ),
        ),
      ),
    );

    print("Widget pumped");
    await tester.pumpAndSettle();

    print("UI settled, checking for icons...");

    expect(find.byIcon(Icons.home_outlined), findsOneWidget); // Searches for the Home-widget
    print("Home icon found\n"); 

    expect(find.byIcon(Icons.notifications_sharp), findsOneWidget); // Searches for the Notifications-widget
    print("Notifications icon found\n");

    expect(find.byIcon(Icons.import_contacts), findsOneWidget); // Searches for the hTutorialsome-widget
    print("Tutorials icon found\n");

    expect(find.byIcon(Icons.group), findsOneWidget); // Searches for the Events-widget
    print("Events icon found\n");

   
    await tester.tap(find.byIcon(Icons.notifications_sharp)); // Simulate tap on Notifications icon 
    await tester.pumpAndSettle();

    print("Tapped on notifications icon\n");

    
    expect(tappedIndex, 1); // Verify that the tap has been registered
    print("Test completed successfully\n\n");
  });
}
