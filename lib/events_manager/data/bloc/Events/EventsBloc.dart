
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'EventsState.dart';

class EventsBloc extends Cubit<EventsState> {
  EventsBloc() : super(EventsState(DateTime.now(), [], DateTime.now(), null));

  void setDate(DateTime date) =>
      emit(EventsState(date, state.events, state.selectedMonth, null));
  void setMonth(DateTime selectedMonth) =>
      emit(EventsState(state.date, state.events, selectedMonth, null));
  void addMonth() =>
      emit(EventsState(state.date, state.events, DateTime(state.selectedMonth.year, state.selectedMonth.month + 1), null));
  void removeMonth() =>
      emit(EventsState(state.date, state.events, DateTime(state.selectedMonth.year, state.selectedMonth.month - 1), null));
  void saveDragStartPosition(DragStartDetails details) =>
      emit(EventsState(state.date, state.events,state.selectedMonth, details));
}