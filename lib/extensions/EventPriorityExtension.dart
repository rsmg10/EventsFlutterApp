import 'package:flutter/material.dart';
import '../events_manager/data/bloc/Events/EventsState.dart';

extension EventPriorityExtension on EventPriority {
  Color get toColor {
    switch (this) {
      case EventPriority.low:
        return Colors.blue.shade100;
      case EventPriority.medium:
        return Colors.yellow.shade100;
      case EventPriority.high:
        return Colors.red.shade100;
    }
  }

  Color get toDarkColor {
    switch (this) {
      case EventPriority.low:
        return Colors.blue.shade700;
      case EventPriority.medium:
        return Colors.yellow.shade700;
      case EventPriority.high:
        return Colors.red.shade800;
    }
  }
}