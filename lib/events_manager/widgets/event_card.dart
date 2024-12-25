
import 'package:flutter/material.dart';
import 'package:test_projects/extensions/EventPriorityExtension.dart';
import 'package:test_projects/extensions/date_time_extension.dart';

import '../data/bloc/Events/EventsState.dart';
import '../screens/events_index.dart';

class EventCard extends StatelessWidget{
  late EventDto data;
  EventCard({super.key,
    required EventDto eventInfo})
  {
    data = eventInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: data.priority.toDarkColor,
        ),),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  color: data.priority.toColor,
              ),
              child: Column(children:
              [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                      child: Text(data.title, style:  TextStyle(fontSize: 24, fontWeight:FontWeight.bold, color: data.priority.toDarkColor ),)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 4),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(data.description, style: TextStyle(fontSize: 10, color: data.priority.toDarkColor))),
                ),
                Row(
                  children: [
                  Row(
                    children: [
                      const SizedBox(width: 10,),
                       Icon(Icons.watch_later, color: data.priority.toDarkColor,),
                      const SizedBox(width: 4),
                      Text("${data.from} - ${data.to}",  style: TextStyle(fontSize: 10, color: data.priority.toDarkColor)),
                      Icon(Icons.pin_drop, color: data.priority.toDarkColor,),
                      Text("${data.location}  ", style: TextStyle(fontSize: 10, color: data.priority.toDarkColor)),
                      const SizedBox(width: 6),
                    ],
                  )
                ],)
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
