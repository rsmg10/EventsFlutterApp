
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsState {
  final DateTime date;
  final DateTime selectedMonth;
  final List<EventDto> events;
  DragStartDetails? dragStartDetails;

  EventsState(this.date, this.events, this.selectedMonth, this.dragStartDetails);
}

class EventDto {
  final String title;
  final String description;
  final String location;
  final String from;
  final String to;
  final EventPriority priority;

  EventDto(this.title, this.description, this.location, this.from, this.to,
      this.priority);
}

enum EventPriority { low, medium, high }
extension Test on EventPriority{
  int toInt (){
    switch (this) {
      case EventPriority.low:
        return 0;
      case EventPriority.medium:
        return 1;
      case EventPriority.high:
        return 2;
    }
  }
}
extension Test2 on int{
  EventPriority toEventPriority (){
    switch (this) {
      case 0:
        return EventPriority.low;
      case 1:
        return EventPriority.medium;
      case 2:
        return EventPriority.high;
      default:
        return EventPriority.low;
    }
  }
  String get toMonth {
    switch (this) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "n/a";
    }
  }
}



