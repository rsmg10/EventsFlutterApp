import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_projects/events_manager/data/bloc/Events/EventsState.dart';
import 'models/type_test.dart';

class HiveService {
  final String  _boxName = "eventBox";

  Future<Box<EventModel>> get _box async =>
      await Hive.openBox<EventModel>(_boxName);

  Future<void> addEvent(EventModel eventModel) async {
    var box = await _box;
    await box.add(eventModel);
  }

  Future<List<EventModel>> getAllEvents() async {
    var box = await _box;
    return box.values.toList();
  }
  Future<List<EventModel>> getEventForDate(DateTime day) async {
    var box = await _box;
    return box.values.where((element) =>element.day.year == day.year &&  element.day.month == day.month &&  element.day.day == day.day ,).toList();
  }
  Future<bool> hasEventForDate(DateTime day) async {
    var box = await _box;
    return box.values.any((element) => element.day.day == day.day,);
  }

  Future<Set<EventPriority>> getEventPrioritiesForDate(DateTime day) async {
    var box = await _box;
    var priorities =  box.values.where((element) => element.day.year == day.year &&  element.day.month == day.month &&  element.day.day == day.day ,).map((e) => e.priority.toEventPriority(),).toSet();
    return priorities;

  }

  Future<void> updateDeck(int index, EventModel eventModel) async {
    var box = await _box;
    await box.putAt(index, eventModel);
  }

  Future<void> deleteEvent(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}