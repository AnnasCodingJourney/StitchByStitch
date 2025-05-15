import 'package:flutter/material.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/search_bar.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'package:flutter_application_1/tutorial_detail_page.dart';

/// TutorialPage
// - https://stackoverflow.com/questions/60908647/flutter-two-2-drawers-on-a-single-page

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialState();
}

class _TutorialState extends State<TutorialPage> {
  double progress = 0.0; // Default progress

  // Tutorial Lists
  // - https://api.flutter.dev/flutter/dart-core/List-class.html
  // Stored them as lists so that they can be `grown` should we need to expand them.
  final List<String> beginnerTechniques = [
    "Introduction to Beginner Techniques",
    "Material Needed",
    "Casting on",
    "The Knit Stitch",
    "The Purl Stitch",
    "The Stockinette Stitch",
    "The Garter Stitch",
    "Casting off"
  ];

  final List<String> intermediateTechniques = [
    "Introduction to Intermediate Techniques",
    "Increases & Decreases",
    "Basic Pattern Reading"
  ];

  final List<String> advancedTechniques = [
    "Introduction to Advanced Techniques",
    "Cable Knitting",
    "Colorwork",
    "Lace Knitting",
  ];

  // Check states for each section of tutorial
  // - https://www.geeksforgeeks.org/dart-late-keyword/
  // - https://api.flutter.dev/flutter/dart-core/List/length.html

  late List<bool> beginnerCheckStates;
  late List<bool> intermediateCheckStates;
  late List<bool> advancedCheckStates;

  // Stores the states of each favourite icon
  late List<bool> beginnerFavourites;
  late List<bool> intermediateFavorites;
  late List<bool> advancedFavorites;

  //  Technique States
  // - https://api.flutter.dev/flutter/widgets/State/initState.html
  // - https://www.scaler.com/topics/initstate-flutter/

  @override
  void initState() {
    super.initState();
    beginnerCheckStates = List.filled(
    
    beginnerTechniques.length, false); // Maybe should change this to `true`
    intermediateCheckStates = List.filled(intermediateTechniques.length, false);
    advancedCheckStates = List.filled(advancedTechniques.length, false);

    beginnerFavourites = List.filled(beginnerTechniques.length, false);
    intermediateFavorites = List.filled(intermediateTechniques.length, false);
    advancedFavorites = List.filled(advancedTechniques.length, false);
  }

  void updateProgress() {
    // Use of a void function to update the progress of the CPI - https://medium.com/flutter-community/the-curious-case-of-void-in-dart-f0535705e529 / https://api.flutter.dev/flutter/dart-core/Iterable/where.html
    int totalCompleted = beginnerCheckStates.where((c) => c).length +
        intermediateCheckStates.where((c) => c).length +
        advancedCheckStates.where((c) => c).length; //

    int totalTutorials = beginnerTechniques.length +
        intermediateTechniques.length +
        advancedTechniques.length; // Combines all of the techniques together

    setState(() {
      // Sets the state of the progress bar and updates it with the above void function
      progress = totalCompleted / totalTutorials;
    });
  }

      int currentPageIndex = 2;

void onTabTapped(BuildContext context, int index) {
  if (index != currentPageIndex) {
    Widget nextPage;
    switch (index) {
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
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }
}

  Widget createSection(String title, List<String> tutorials,
      List<bool> checkStates, List<bool> favoriteStates) {
    return Card(
      // - https://api.flutter.dev/flutter/material/Card-class.html / https://dart.dev/language/functions#:~:text=Return%20values,-%23&text=All%20functions%20return%20a%20value,appended%20to%20the%20function%20body.&text=To%20return%20multiple%20values%20in,the%20values%20in%20a%20record.
      color: const Color.fromRGBO(137, 57, 57, 1),
      child: Column(
        children: [
          ExpansionTile(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors
                      .white), // https://api.flutter.dev/flutter/painting/TextStyle-class.html
            ),
            trailing: Icon(Icons.arrow_drop_down, color: Colors.white,),
            children: List.generate(tutorials.length, (index) {
              return ListTile(
                leading: const Icon(Icons.import_contacts, size: 48.0),
                tileColor: Color.fromRGBO(255, 237, 235,1), // Changes the colour of the Tutorial - https://borderleft.com/toolbox/rgba/ 
                title: Text(tutorials[index],
                    style: const TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TutorialonClickPage(
                          title: tutorials[
                              index]), // Pulls from the indexed tutorial
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card.filled(
                      color: Colors.transparent,
                      child: IconButton(
                        // https://api.flutter.dev/flutter/material/IconButton-class.html
                        isSelected: favoriteStates[index],
                        icon: const Icon(Icons.star_border_outlined),
                        selectedIcon: const Icon(Icons.star),
                        onPressed: () {
                          setState(() {
                            favoriteStates[index] = !favoriteStates[index];
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Card.filled(
                      color: Colors.transparent,
                      child: Checkbox(
                        // https://api.flutter.dev/flutter/material/Checkbox-class.html
                        value: checkStates[index],
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            checkStates[index] = value ?? false;
                            updateProgress();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(),
        toolbarHeight: kToolbarHeight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          //- https://docs.flutter.dev/ui/widgets/scrolling
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                // Introduction and Progress Sections
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 5),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Text(
                              """Welcome Back! 
Continue with your 
tutorial?""",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width:
                                100, // Still can't figure out how to change the `size` of the Circle
                            height: 100,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  // https://amalpaul92.medium.com/how-to-make-a-filled-tracked-style-circular-progress-bar-in-flutter-3b1c5d1cd4f3
                                  value: progress,
                                  strokeWidth:
                                      2.5, // Thicker stroke doesn't really increase the size of the circle though
                                  backgroundColor:
                                      const Color.fromRGBO(235, 179, 179, 1),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color.fromRGBO(255, 124, 138, 1)),
                                ),
                                Text(
                                    "${(progress * 100).toInt()}%", // Calculation to get the percentage - https://www.dhiwise.com/post/insight-into-dart-string-interpolation-for-flutter-developers
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Tutorial Sections
                // - This is a more efficient way of generating these!
                createSection("Beginner", beginnerTechniques,
                    beginnerCheckStates, beginnerFavourites),
                //const Divider(),
                createSection("Intermediate", intermediateTechniques,
                    intermediateCheckStates, intermediateFavorites),
                //const Divider(),
                createSection("Advanced", advancedTechniques,
                    advancedCheckStates, advancedFavorites),
              ],
            ),
          ),
        ),
      ),
    
      bottomNavigationBar: CustomBottomNavigationBar(
        currentPageIndex: currentPageIndex,
        onTap: (index) => onTabTapped(context, index),
          )
        );
  }
}
