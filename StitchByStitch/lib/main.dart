import 'package:flutter/material.dart';
import 'package:flutter_application_1/event_data.dart';
import 'package:flutter_application_1/image_provider_class.dart';
// import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications_data.dart';
// import 'package:flutter_application_1/search_bar.dart';
// import 'package:flutter_application_1/notifications.dart';
// import 'package:flutter_application_1/events.dart';
// import 'package:flutter_application_1/social_feed.dart';
// import 'package:flutter_application_1/tutorials.dart';
import 'package:flutter_application_1/welcome_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => EventData()), // Stores events Data (C-GPT)
        ChangeNotifierProvider(
            create: (context) =>
                NotificationData()), // Stores Notification Data (C-GPT)
        ChangeNotifierProvider(create: (context) => ImageProviderClass()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: WelcomePage(), // Opens the login/sign in screen on start up
      debugShowCheckedModeBanner:
          false, // https://stackoverflow.com/questions/48893935/how-can-i-remove-the-debug-banner-in-flutter
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int currentPageIndex = 0;

//   final NavigationDestinationLabelBehavior labelBehavior =
//       NavigationDestinationLabelBehavior.onlyShowSelected;

//   final List<Widget> _pages = [
//     // Changed these to consts because the application told me to - no clue why
//     const SocialFeed(),
//     const NotificationsPage(),
//     const TutorialPage(),
//     const EventsScreen(),
//   ];

//   void onTabTapped(int index) {
//     if (index != currentPageIndex) {
//       // Define the navigation logic
//       Widget nextPage;
//       switch (index) {
//         // Simple switch statements that I use all the time in C++. Here's a link on them; https://dart.dev/language/branches
//         case 0:
//           nextPage = const HomeScreen(); // Replace with your home page
//           break;
//         case 1:
//           nextPage =
//               const NotificationsPage(); // Replace with your notifications page
//           break;
//         case 2:
//           nextPage = TutorialPage(); // Stay on tutorials
//           break;
//         case 3:
//           nextPage = const EventsScreen(); // Replace with your events page
//           break;
//         default:
//           return;
//       }

//       Navigator.pushReplacement(
//         // https://api.flutter.dev/flutter/widgets/Navigator/pushReplacement.html
//         context,
//         MaterialPageRoute(builder: (context) => nextPage),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Changed this to support the new way of building the navigation bar
//     return Scaffold(
//       body: IndexedStack(index: currentPageIndex, children: _pages),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentPageIndex: currentPageIndex,
//         onTap: (index) {
//           setState(() {
//             currentPageIndex = index;
//           }
//           );
//         },
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: SearchAppBar(),
//         toolbarHeight: kToolbarHeight,
//       ),
//       body: const Center(
//         child: Text("Home Page Content Here"),
//       ),

//       // bottomNavigationBar: CustomBottomNavigationBar(
//       //   currentPageIndex: currentPageIndex,
//       //   onTap: onTabTapped,
//       //     ),
//     );
//   }
// }
