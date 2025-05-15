// ignore_for_file: avoid_print

import 'package:flutter_application_1/notifications_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationData Tests.', () {
    late NotificationData notificationData;

    setUp(() {
      notificationData = NotificationData();
      print("\nSetup: NotificationData instance created."); // Sets up the notification Instance 
    });

    test('Initial notifications list should contain 3 notifications.', () { // Checks to see if there are three notifications in the notifications list
      print("Checking initial notifications...");
      expect(notificationData.notifications.length, 3);
      print("Initial notifications verified.");
    });

    test('Adding a notification increases the count.', () {
      final newNotification = NotificationModel(
        message: "Test Notification.",
        type: NotificationType.user,
        time: "",
      );

      print("Before adding: ${notificationData.notifications.length} notifications.");
      notificationData.addNotification(newNotification);
      print("After adding: ${notificationData.notifications.length} notifications.");

      expect(notificationData.notifications.length, 4);
      expect(notificationData.notifications.last.message, "Test Notification.");
      expect(notificationData.notifications.last.time.length, 16); // Ensures time was set
      print("Notification added successfully.");
    });

    test('Removing a notification decreases the count.', () { //
      print("Before removing: ${notificationData.notifications.length} notifications.");
      notificationData.removeNotification(0);
      print("After removing: ${notificationData.notifications.length} notifications.");

      expect(notificationData.notifications.length, 2);
      print("Notification removed successfully.");
    });

    test('Removing out-of-bounds index should throw an error.', () { // Removing a notification that's indexed outside the bounds of the current list
      print("Attempting to remove an out-of-bounds index...");
      expect(() => notificationData.removeNotification(10), throwsRangeError);
      print("Out-of-bounds removal correctly threw an error.");
    });
  });
}