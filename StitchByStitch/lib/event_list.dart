import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_data.dart';
import 'event_details.dart';

//class to save events on the registration page

class EventList extends StatelessWidget {
  const EventList({super.key});

//had help from chatgpt with implementation of how to delete events and show as list -
//also https://api.flutter.dev/flutter/widgets/ListView-class.html

  @override
  Widget build(BuildContext context) {
    return Consumer<EventData>(
      builder: (context, eventData, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: eventData.registeredEvents.length,
          itemBuilder: (context, index) {
            final event = eventData.registeredEvents[index];

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the event details page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(event: event),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 221, 221),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Color.fromARGB(255, 137, 55, 55),
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.event,
                        color: Color.fromARGB(255, 137, 55, 55)),
                    title: Text(
                      event.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${event.userName} - ${event.userEmail}",
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,
                          color: const Color.fromARGB(255, 93, 21, 16)),
                      onPressed: () =>
                          _confirmDelete(context, eventData, event),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

// pop up to ask to confirm deletion
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
