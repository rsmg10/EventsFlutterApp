import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_projects/events_manager/data/bloc/AddEvent/AddEventBloc.dart';
import 'package:test_projects/extensions/EventPriorityExtension.dart';
import 'package:test_projects/extensions/context_extension.dart';
import 'package:test_projects/extensions/text_editing_controller_extension.dart';

import '../data/bloc/AddEvent/AddEventState.dart';
import '../data/bloc/Events/EventsBloc.dart';
import '../data/bloc/Events/EventsState.dart';
import '../data/hive/event_hive_service.dart';

class AddEventPage extends StatefulWidget {
  final DateTime day;

  AddEventPage({super.key, required this.day});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  EventPriority? priority;

  TextEditingController titleController = new TextEditingController();

  TextEditingController descriptionController = new TextEditingController();

  FocusNode titleFocus = FocusNode();

  FocusNode descriptionFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Future<void> _selectToTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        context.read<AddEventBloc>().setToDate(pickedTime);
      }
    }

    Future<void> _selectFromTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        context.read<AddEventBloc>().setFromDate(pickedTime);
      }
    }
    return BlocProvider(
      create: (context) => AddEventBloc(widget.day),
      child: BlocListener<AddEventBloc, AddEventState>(
        listener: (context, state) {},
        // listenWhen: (previous, current) => current.events.length > 3,
        child: BlocBuilder<AddEventBloc, AddEventState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Container(
                    width:  MediaQuery.sizeOf(context).width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Enter event form", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                        ),
                        const SizedBox(height: 24,),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter title',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12),),
                            ),
                          ),
                          focusNode: titleFocus,
                          onTapOutside: (event) => titleFocus.unfocus(),
                          controller: titleController,
                        ),
                        const SizedBox(height: 16,),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Description',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          focusNode: descriptionFocus,
                          onTapOutside: (event) =>
                              descriptionFocus.unfocus(),
                          controller: descriptionController,
                          minLines: 3,
                          maxLines: 10,
                        ),
                        DropdownButton(
                          hint: const Text("Select Priority"),
                          isExpanded: true,
                          menuWidth: context.width * .5,
                          value: priority,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items:
                              EventPriority.values.map((EventPriority i) {
                            return DropdownMenuItem(
                              value: i,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(i.name),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    height: 20,
                                    width: 20,
                                    decoration:
                                        BoxDecoration(color: i.toDarkColor),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (EventPriority? value) {
                            priority = value;
                            context.read<AddEventBloc>().setPriority(value);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<AddEventBloc, AddEventState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () async =>
                                          await _selectFromTime(context),
                                      child: Text(state.from?.toString() ??
                                          "Select From Time")),
                                  TextButton(
                                      onPressed: () async =>
                                          await _selectToTime(context),
                                      child: Text(state.to?.toString() ??
                                          "Select To Time")),
                                ],
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (titleController.isEmpty ||
                                descriptionController.isEmpty ||
                                state.from == null ||
                                state.to == null ||
                                state.priority == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Some data is missing from the form.'),
                                ),
                              );
                            } else {
                              context.read<AddEventBloc>().setData(
                                  titleController.value.text,
                                  descriptionController.value.text,
                                  state.priority ?? EventPriority.low);

                              titleController.text = "";
                              descriptionController.text = "";
                              priority = null;
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Submit event"),
                        ),
                        // FutureBuilder(
                        //     future: HiveService().hasEventForDate(state.date),
                        //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        //       if (snapshot.connectionState == ConnectionState.waiting) {
                        //         // Show a loading indicator while waiting for the future
                        //         return SizedBox();
                        //       } else if (snapshot.hasError) {
                        //         // Handle error
                        //         return Text("Error: ${snapshot.error}");
                        //       } else if (snapshot.hasData && snapshot.data!) {
                        //         // Display widget if condition is true
                        //         return Text("Condition met: Widget A");
                        //       } else {
                        //         // Display widget if condition is false
                        //         return SizedBox();
                        //       }
                        //     })
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
