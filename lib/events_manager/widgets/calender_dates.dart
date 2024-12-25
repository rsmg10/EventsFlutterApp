import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_projects/events_manager/data/hive/event_hive_service.dart';
import 'package:test_projects/extensions/EventPriorityExtension.dart';
import '../constants/weekdays.dart';
import '../data/bloc/Events/EventsBloc.dart';
import '../data/bloc/Events/EventsState.dart';
import '../screens/events_index.dart';

class CalenderDates extends StatefulWidget {
  const CalenderDates({super.key});

  @override
  State<CalenderDates> createState() => _CalenderDatesState();
}

class _CalenderDatesState extends State<CalenderDates> {
  int crossAxisCount = 7;
  int totalItems = 31;
  bool needSpace = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return BlocListener<EventsBloc, EventsState>(
          listener: (context, state) => {needSpace = true},
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: [
                  ...Weekdays.values.map(
                    (x) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 7 - 10,
                      child: Center(child: Text(x.name)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (state.dragStartDetails?.globalPosition != null) {
                    var dx = (state.dragStartDetails?.globalPosition.dx ?? 0)
                        - details.globalPosition.dx;
                    if (dx > 0) {
                      context.read<EventsBloc>().addMonth();
                    } else {
                      context.read<EventsBloc>().removeMonth();
                    }
                  }
                },
                onHorizontalDragStart: (details) {
                  context.read<EventsBloc>().saveDragStartPosition(details);
                },
                child: SizedBox(
                  height: 350,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      ...generateEmptyPad(state),
                      ...List.generate(
                        DateTime(state.selectedMonth.year,
                                state.selectedMonth.month + 1, 1)
                            .subtract(const Duration(days: 1))
                            .day,
                        (index) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width / 7 - 10,
                            height: 60,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: state.date ==
                                              DateTime(
                                                  state.selectedMonth.year,
                                                  state.selectedMonth.month,
                                                  index + 1)
                                          ? EventPriority.low.toColor
                                          : Colors.transparent),
                                  // height: 60,
                                  // width: MediaQuery.sizeOf(context).width / 7 - 10,
                                  child: TextButton(
                                      onPressed: () {
                                        context.read<EventsBloc>().setDate(
                                            DateTime(
                                                state.selectedMonth.year,
                                                state.selectedMonth.month,
                                                index + 1));
                                      },
                                      child: Center(child: Text("${index + 1}"))),
                                ),
                                FutureBuilder(
                                    future: HiveService().getEventPrioritiesForDate(
                                      DateTime(
                                          state.selectedMonth.year,
                                          state.selectedMonth.month, index + 1),
                                    ),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Set<EventPriority>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox();
                                      } else if (snapshot.hasError) {
                                        return Text("Error: ${snapshot.error}");
                                      } else if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty   ) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: snapshot.data?.map((e) => Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                                height: 4,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    color: e.toDarkColor),
                                            ),
                                          ),).toList()??[],
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    })
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> generateEmptyPad(EventsState state) {
    List<Widget> result = [];
    int index = 1;

    while (needSpace) {
      var day =
          DateTime(state.selectedMonth.year, state.selectedMonth.month, index)
              .weekday;
      if (day == Weekdays.sat.index + 1) {
        needSpace = false;
        return result;
      }
      index++;
      result.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        height: 50,
        width: MediaQuery.sizeOf(context).width / 7 - 10,
        child: const Text(""),
      ));
    }

    return result;
  }
}
