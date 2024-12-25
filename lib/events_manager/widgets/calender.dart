import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/bloc/Events/EventsBloc.dart';
import '../data/bloc/Events/EventsState.dart';
import '../screens/events_index.dart';
import 'calender_dates.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) => Column(
        children: [
          SizedBox(
            child: Center(
              child: Text("${state.date.day}-${state.date.month}-${state.date.year}"),
            ),
          ),
          SizedBox(
            child: Center(
              child: Text("${state.selectedMonth.month.toMonth} ${state.selectedMonth.year}"),
            ),
          ),
          const CalenderDates()
        ],
      ),
    );
  }
}
