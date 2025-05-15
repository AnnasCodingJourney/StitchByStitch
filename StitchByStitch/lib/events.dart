import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/search_bar.dart';
import 'package:flutter_application_1/registrations.dart';
import 'package:flutter_application_1/event_data.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:provider/provider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

// screen for events with image and text information - users can register for each event
//had some help from chatgpt and stack overflow for linkify but couldn't get it to work
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int currentPageIndex = 3;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchAppBar(),
          toolbarHeight: kToolbarHeight,
        ),

        //red rectangle manage registrations button
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 137, 57, 57),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 4)
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Text(
                            "Manage Registrations",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          const Positioned(
                            right: 16,
                            child: Icon(Icons.arrow_right,
                                color: Colors.white, size: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),

              // upcoming events button
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 137, 57, 57),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 4)
                        ],
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Upcoming events",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //when adding new events, add buildEventSection() and customise - don't have database so this is alternative
              // event 1 - valentines knit
              buildEventSection(
                context,
                title: "Valentine's Knit",
                description:
                    "Come along to KnitStitch Coffee and let’s knit together!",
                date: "14th Feb, 3pm - 6pm",
                location: "Livingstone Tower, 26 Richmond St, Glasgow G1 1XH",
                eventImage:
                    "https://gina-michele.com/wp-content/uploads/2023/01/How-to-Knit-a-Heart-Shape3-768x768.jpg",
                isFree: true,
              ),
              //page divider between events
              Divider(
                height: 100,
                color: Color.fromARGB(255, 137, 57, 57),
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),

              // event 2 - knit with a cat
              buildEventSection(
                context,
                title: "Knit with a cat",
                description:
                    "Join us for a relaxing knitting session with a cat of your choice.",
                date: "20th Feb, 2pm - 5pm",
                location: "Graham Hills, 40 George St, Glasgow G1 1XP",
                eventImage:
                    "https://media.istockphoto.com/id/656780474/photo/kitten.jpg?s=612x612&w=0&k=20&c=eF6y5xtxwow5lWA5bs72Q-vZUhmcqdcF45aYDZvvDn8=",
                isFree: false,
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onTap: (index) => onTabTapped(context, index),
        ));
  }

  // event widget
  Widget buildEventSection(
    BuildContext context, {
    required String title,
    required String description,
    required String date,
    required String location,
    required String eventImage,
    required bool isFree,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            //made the image a URL for ease
            child: Image.network(
              eventImage,
              height: 412,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),

          // event description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 10),

          // time, date, location
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
                // location with Linkify - had to remove as was causing errors
                Linkify(
                  text: location,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Event: ',
                    style: const TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      //did like this as only one word is underlined https://api.flutter.dev/flutter/painting/TextSpan-class.html
                      TextSpan(
                          //bool for whether it's a free event
                          text: isFree ? 'Free' : 'Paid',
                          style: const TextStyle(
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // links to register and find out more
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context:
                            context, // had help from chatgpt with implementation of registering for events
                        builder: (BuildContext context) {
                          TextEditingController nameController =
                              TextEditingController();
                          TextEditingController emailController =
                              TextEditingController();

                          return AlertDialog(
                            title: Text("Register for $title"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),
                                TextField(
                                  controller: emailController,
                                  decoration:
                                      const InputDecoration(labelText: "Email"),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // close when cancel is clicked
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 137, 55, 55)),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String emailPattern =
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                  RegExp regex = RegExp(emailPattern);

                                  if (name.isEmpty || !regex.hasMatch(email)) {
                                    // show error message if incorrect details filled in
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Invalid Details"),
                                          content: Text(
                                              "Please enter a valid name and email."),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text("OK",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    // ff valid name and email entered, add the event and close the dialog
                                    Provider.of<EventData>(context,
                                            listen: false)
                                        .addEvent(
                                      Event(
                                        title: title,
                                        description: description,
                                        date: date,
                                        location: location,
                                        isFree: isFree,
                                        userName: name,
                                        userEmail: email,
                                      ),
                                    );
                                    Navigator.of(context).pop(); // close pop up
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 137, 55, 55),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Register"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 137, 57, 57),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromARGB(255, 137, 57, 57),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                // find out more link text
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showInfoDialog(context, title, description);
                    },
                    child: const Text(
                      "Find out more",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 137, 57, 57),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromARGB(255, 137, 57, 57),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//find out more pop up - customised to each event description but can change if separate info needed
  void _showInfoDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("About $title"),
          content: Text(description),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 137, 57, 57)),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
