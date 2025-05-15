import 'package:flutter/material.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications_data.dart';
import 'package:flutter_application_1/search_bar.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/event_data.dart';

/// Notifications Page
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    List<NotificationModel> notifications =
        Provider.of<NotificationData>(context).notifications;
    List<Event> registeredEvents =
        Provider.of<EventData>(context).registeredEvents;

    int currentPageIndex = 1;

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

    return Scaffold(
        appBar: AppBar(
          title: SearchAppBar(),
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView(
              children: [
                // ✅ Correctly map notifications (C-GPT)
                ...notifications
                    .asMap()
                    .entries
                    .map((entry) =>
                        _buildNotificationTile(entry.value, entry.key))
                    ,

                // ✅ Correctly map events as notifications (C-GPT)
                ...registeredEvents
                    .asMap()
                    .entries
                    .map((entry) => _buildNotificationTile(
                        NotificationModel(
                          message:
                              "Upcoming Event: ${entry.value.title} on ${entry.value.date}",
                          type: NotificationType.event,
                          time: '',
                        ),
                        entry.key)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onTap: (index) => onTabTapped(context, index),
        )
        );
  }

  // C-GPT
  Widget _buildNotificationTile(NotificationModel notification, int index) {
    IconData getIconForType(NotificationType type) {
      switch (type) {
        case NotificationType.event:
          return Icons.group; // Icon for Event notifications
        case NotificationType.system:
          return Icons.system_update; // Icon for System update notifications
        case NotificationType.user:
          return Icons.person; // Icon for User-generated notifications
      }
    }

    return Dismissible(
      // https://docs.flutter.dev/cookbook/gestures/dismissible
      key: Key(notification.message), // Each item needs a key
      direction: DismissDirection.endToStart, // Right to Left
      background: Container(
        // Inside this container are the generic values
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        NotificationModel removedNotification = notification;

        Provider.of<NotificationData>(context, listen: false)
            .removeNotification(index);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Notification dismissed"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                Provider.of<NotificationData>(context, listen: false)
                    .addNotification(
                        removedNotification); // Allows the user to undo the swiping of the notification (in instances of accidents)
              },
            ),
          ),
        );
      },
      child: Card(
        // Wrapped the `ListTile` in a `Card`
        color: Color.fromRGBO(255, 237, 235, 1),
        child: ListTile(
          leading: Icon(getIconForType(notification.type)),
          title: Text(notification.message),
          subtitle: const Text("Tap to view details."),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notification.time.isNotEmpty ? notification.time : "Just now",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_horiz),
                onSelected: (String result) {
                  if (result == 'delete') {
                    Provider.of<NotificationData>(context, listen: false)
                        .removeNotification(index);
                  } else if (result == 'details') {
                    _showNotificationDetails(context, notification.message);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Delete'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'details',
                    child: ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Details'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            _showNotificationDetails(context, notification.message);
          },
        ),
      ),
    );
  }
}

/// 🔹 Function to show notification details in a dialog (C-GPT)
void _showNotificationDetails(BuildContext context, String notification) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Notification Details'),
        content: Text(notification), // Displaying the notification details
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
