import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../bloc/Events/EventsState.dart';
part 'type_test.g.dart';

@HiveType(typeId: 1)
class EventModel {
  EventModel(this.name, this.title, this.description, this.day, this.from, this.to, this.priority);
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String description;
  @HiveField(3)
  late DateTime day;
  @HiveField(4)
  late String from;
  @HiveField(5)
  late String to;
  @HiveField(6)
  late int priority;
}

