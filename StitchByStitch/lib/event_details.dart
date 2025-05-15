import 'package:flutter/material.dart';
import 'package:flutter_application_1/registrations.dart';
import 'package:provider/provider.dart';
import 'event_data.dart';
import 'events.dart';
import 'search_bar.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

//class to show extra events detail screen when clicking on registered event. Can cancel/delete event registration
//from here too. Used mostly code from other events and registrations files.

  const EventDetailsScreen({super.key, required this.event});

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
                            builder: (context) => RegistrationsScreen(),
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

              // registrations word
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Registrations",
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 137, 57, 57)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // event title
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // time, date, location
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.date,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      event.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Event: ',
                        style: const TextStyle(fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: event.isFree
                                ? 'Free'
                                : 'Paid', // Directly check the bool value
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black,
                      child: OutlinedButton(
                        onPressed: () {
                          final eventData =
                              Provider.of<EventData>(context, listen: false);
                          _confirmDelete(context, eventData, event);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Text(
                          'Cancel Registration',
                          style: TextStyle(
                              color: Color.fromARGB(255, 137, 57, 57)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40), // space between buttons

                    // view details button
                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black,
                      child: OutlinedButton(
                        onPressed: () {
                          _showInfoDialog(
                              context, event.title, event.description);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                              color: Color.fromARGB(255, 137, 57, 57)),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 110,
                    ),

                    //upcoming events text link
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextButton(
                            onPressed: () {
                              // navigate to events screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EventsScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Upcoming Events',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 137, 57, 57),
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color.fromARGB(255, 137, 57, 57),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

//cancel event pop up dialog

  void _confirmDelete(BuildContext context, EventData eventData, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure you want to delete the Registration?"),
          content: Text(
              "If you delete the registration for this event, you will not be able to attend this event and will have to register again."),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style:
                      TextStyle(color: const Color.fromARGB(255, 66, 66, 66))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                eventData.removeEvent(event); //delete event from list
                Navigator.of(context).pop(); //close pop up
                Navigator.push(
                  //navigate back to events page
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventsScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

//events details pop up
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
