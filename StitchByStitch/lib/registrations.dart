import 'package:flutter/material.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/search_bar.dart';
import 'package:flutter_application_1/event_list.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'package:flutter_application_1/tutorials.dart';

class RegistrationsScreen extends StatefulWidget {
  const RegistrationsScreen({super.key});

  @override
  State<RegistrationsScreen> createState() => _RegistrationsScreenState();
}

//screen that shows the updatable list of events registered by user and allows them to delete
//had help from chatgpt for implementation

class _RegistrationsScreenState extends State<RegistrationsScreen> {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              //manage registrations button
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 0, left: 5, right: 5, bottom: 10),
                        height: 56,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 137, 57, 57), // Red from Figma
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 4),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Text(
                              "Manage Registrations",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            const Positioned(
                              left: 16,
                              child: Icon(Icons.arrow_left,
                                  color: Colors.white, size: 40),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // event list widget with lists of events as users register for them
              EventList(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onTap: (index) => onTabTapped(context, index),
        ));
  }
}
