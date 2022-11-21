import 'package:flutter/material.dart';

//* Por lo tanto se creo este objeto-modelo
class Event {
  late final String title;
  late final String description;
  late final DateTime from;
  late final DateTime to;
  late final Color backgroundColor;
  late final bool isAllDay;

  Event({
    Key? key,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.blueAccent,
    this.isAllDay = false,
  });
}
