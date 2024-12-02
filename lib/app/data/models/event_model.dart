import 'package:flutter/material.dart';

class Event {
  String name;
  DateTime date;
  TimeOfDay time;
  String location;
  String description;

  Event({
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });
}
