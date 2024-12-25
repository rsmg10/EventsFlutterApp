
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_projects/extensions/date_time_extension.dart';

import '../data/bloc/Events/EventsBloc.dart';
import '../data/bloc/Events/EventsState.dart';
import '../data/hive/event_hive_service.dart';
import '../data/hive/models/type_test.dart';
import 'event_card.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) => Column(
        children: [
          FutureBuilder(
              future: HiveService().getEventForDate(state.date),
              builder: (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for the future
                  return SizedBox();
                } else if (snapshot.hasError) {
                  // Handle error
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData ) {
                  // Display widget if condition is true
                  return Column(
                    children: snapshot
                        .data!
                        .where((element) => true)
                        .map((e) =>
                        EventCard(
                          eventInfo: EventDto(
                              e.title,
                              e.description,
                              e.title,
                              e.from,
                              e.to,
                              e.priority.toEventPriority(),
                          ),
                        )
                    ).toList()
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
    );
  }
}