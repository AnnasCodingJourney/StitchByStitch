import 'package:flutter/material.dart';
import 'package:flutter_application_1/eigth_Page.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:flutter_application_1/social_feed.dart';

class TutorialonClickPage extends StatefulWidget {
  final String title;

  const TutorialonClickPage({super.key, required this.title});

  @override
  TutorialonClickPageState createState() => TutorialonClickPageState();
}

class TutorialonClickPageState extends State<TutorialonClickPage> {
  // Maybe the use of a Map to save the titles and their corresponding content?
  // - https://docs.flutter.dev/cookbook/lists/mixed-list
  // - https://medium.com/@harshitp108/how-to-use-map-in-flutter-dart-21042334f537
  // - https://www.flutterclutter.dev/flutter/basics/2022-12-06-static-final-const-dynamic-var/
  // Rather than having one for each

  int currentPageIndex = 2; // This is the tutorials tab

@override // After some trial and error, I found that this below works.
void didChangeDependencies() { // https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html
  super.didChangeDependencies();

  // Perform navigation if the title matches "Casting on", hopefully this fixes the issue! 
  if (widget.title == "Casting on") {
    Future.delayed(Duration.zero, () { // https://stackoverflow.com/questions/64186001/what-is-the-difference-between-future-delayedduration-zero-and-schedul
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EigthPage()),
      );
    });
  }
}

  void onTabTapped(int index) {
    if (index != currentPageIndex) {
      // Define the navigation logic
      Widget nextPage;
      switch (index) {
        // Simple switch statements that I use all the time in C++. Here's a link on them; https://dart.dev/language/branches
        case 0:
          nextPage = const SocialFeed();
          break;
        case 1:
          nextPage = const NotificationsPage();
          break;
        case 2:
          nextPage = TutorialPage();
          break;
        case 3:
          nextPage = const EventsScreen();
          break;
        default:
          return;
      }

      Navigator.pushReplacement(
        // https://api.flutter.dev/flutter/widgets/Navigator/pushReplacement.html
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  final Map<String, List<Widget>> tutorialContent = {
    // Will mess with the stateless widget if it's not a final
    'Casting on': [],
    // 'Material Needed':[ - Edited this out as we won't really be needing it.
    //   Card(
    //     child:Text( "Welcome to the Material Needed section!"),
    //   )
    // ]
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> contentWidgets = tutorialContent[widget
            .title] ?? // This is a `null-coalescing` operator - https://dart.dev/language/operators
        [
          // Generic content page found within

          // This is all built from Anna's code!
          Center(
              child: Container(
                  margin:
                      EdgeInsets.only(top: 53, left: 5, right: 5, bottom: 18),
                  height: 56,
                  width: double.infinity, // used to create the space on top
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 137, 57, 57),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 4)
                        // creating drop shadow: https://www.youtube.com/watch?v=bSZiF48RiNY
                        // shadows and decoration box : https://medium.com/@bosctechlabs/how-to-add-drop-shadow-effect-in-flutter-477360b21922
                      ]),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(widget.title, //Title text
                          style:
                              TextStyle(fontSize: 24, color: Colors.white))))),
          //Text("Content for $title will be added soon.", style: TextStyle(fontSize: 18))
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 18, left: 43, right: 10),
                    height: 30,
                    width: 250,
                    child: Text(
                      "Introduction",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),

          // Text block 1
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 18, left: 43, right: 10),
                    height: 114,
                    width: 250,
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
              ),
            ],
          ),

          // Text block 2
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 18, left: 43, right: 10),
                    height: 100,
                    width: 250,
                    child: Text(
                      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
              ),
            ],
          ),
        ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)), // Title of the tutorial
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
            // Added a scrollView so that the user can scroll through the content!
            child: Column(children: contentWidgets)),
      )),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentPageIndex: currentPageIndex,
        onTap: onTabTapped,
      ),
    );
  }
}
