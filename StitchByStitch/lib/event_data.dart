import 'package:flutter/material.dart';

//a way to store user events on the registrations screen as the user registers for them, then removes once the user deletes
//had help from chatgpt for the implementation.

class Event {
  final String title;
  final String description;
  final String date;
  final String location;
  final bool isFree;
  final String userName;
  final String userEmail;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.isFree,
    required this.userName,
    required this.userEmail,
  });
}

class EventData with ChangeNotifier {
  final List<Event> _registeredEvents = [];

  List<Event> get registeredEvents => _registeredEvents;

  void addEvent(Event event) {
    _registeredEvents.add(event);
    notifyListeners();
  }

  void removeEvent(Event event) {
    _registeredEvents.remove(event);
    notifyListeners();
  }
}
