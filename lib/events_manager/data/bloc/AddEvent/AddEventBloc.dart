import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_projects/events_manager/data/bloc/Events/EventsState.dart';
import 'package:test_projects/events_manager/data/hive/event_hive_service.dart';
import 'package:test_projects/extensions/date_time_extension.dart';
import '../../hive/models/type_test.dart';
import 'AddEventState.dart';

class AddEventBloc extends Cubit<AddEventState>{
   AddEventBloc(DateTime day) : super(AddEventState(title: "", description:  "",day: day,from: null, to: null,  priority: null));
   void setData(String title, String description,  EventPriority priority) {
     emit(AddEventState(title: title, description: description, day: state.day, from: state.from, to: state.to, priority: priority));
     var from = state.from.toShortDate;
     final to = state.to.toShortDate;
     print(from);
     print(to);
     HiveService().addEvent(EventModel("", title, description,  state.day, from, to, priority.toInt()));
   }
   void setToDate(TimeOfDay to) {
     emit(AddEventState(title:state.title, description: state.description, day: state.day, from: state.from, to: to, priority: state.priority));
   }
   void setFromDate(TimeOfDay from) {
     emit(AddEventState(title:state.title, description: state.description, day: state.day, from: from, to: state.to, priority: state.priority));
   }
  void setPriority(EventPriority? value)
  => emit(AddEventState(title: state.title, description: state.description, day: state.day, from: state.from, to: state.to, priority: value));
}





