import 'package:flutter/material.dart';


// Class that holds the Notification types
// - This can be expanded on to allow for further refinement of notifications.
class NotificationModel {
  final String message;
  final NotificationType type;
  final String time;

  NotificationModel({required this.message, required this.type, required this.time});
}

enum NotificationType { event, system, user } // Used these before in C++, but they still confuse me!

class NotificationData with ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(message: "New Interaction from annas.knittingjourney.", type: NotificationType.user, time: ""),
    NotificationModel(message: "System update available.", type: NotificationType.system, time: "3hr"),
    NotificationModel(message: "Reminder: Event at 3 PM.", type: NotificationType.event, time:"27/03"),
  ];

  List<NotificationModel> get notifications => _notifications;

  void removeNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }

void addNotification(NotificationModel notification) {
  _notifications.add(NotificationModel(
    message: notification.message,
    type: notification.type,
    time: DateTime.now().toLocal().toString().substring(0, 16), // Shortened
  ));
  notifyListeners();
}
}
