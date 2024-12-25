
import 'package:flutter/material.dart';

import '../../../screens/events_index.dart';
import '../Events/EventsState.dart';

class AddEventState {
  final String title;
  final String description;
  final DateTime day;
  final TimeOfDay? from;
  final TimeOfDay? to;
  final EventPriority? priority;
  AddEventState({required this.title, required this.description, required this.day, required this.from, required this.to, required this.priority});
}




