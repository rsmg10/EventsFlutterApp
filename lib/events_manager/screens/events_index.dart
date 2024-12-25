import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_projects/events_manager/widgets/calender.dart';
import 'package:test_projects/extensions/context_extension.dart';
import '../data/bloc/Events/EventsBloc.dart';
import '../data/bloc/Events/EventsState.dart';
import '../widgets/events_list.dart';
import 'add_event.dart';
import '../widgets/event_card.dart';

class EventsIndex extends StatelessWidget {
  const EventsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventsBloc(),
      child: BlocBuilder<EventsBloc, EventsState>(
        builder: (BuildContext context, EventsState state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Counter')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Calender(),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: context.width * 0.05,
                        ),
                        child: const Text("Schedule",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => BlocProvider.value(
                                value: context.read<EventsBloc>(),
                                child:  AddEventPage(day: state.date),
                              ),
                            ),
                          )
                        },
                        child: const Row(
                          children: [Icon(Icons.add), Text("Add Event")],
                        ),
                      ),
                    ],
                  ),
                  EventsList()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}






