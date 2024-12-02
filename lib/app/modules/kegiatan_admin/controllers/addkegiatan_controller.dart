import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ukm_app/app/data/models/event_model.dart';

class AddkegiatanController {
  final List<Event> _events = [];

  List<Event> get events => _events;

  void addEvent(String name, DateTime date, TimeOfDay time, String location,
      String description) {
    _events.add(Event(
      name: name,
      date: date,
      time: time,
      location: location,
      description: description,
    ));
  }

  void updateEvent(int index, String name, DateTime date, TimeOfDay time,
      String location, String description) {
    _events[index] = Event(
      name: name,
      date: date,
      time: time,
      location: location,
      description: description,
    );
  }

  void deleteEvent(int index) {
    _events.removeAt(index);
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String formatTime(TimeOfDay time, BuildContext context) {
    return time.format(context);
  }
}
