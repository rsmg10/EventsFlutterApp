
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String get  toShortDate => "$year-$month-$day";
  String get  toShortTime => "$hour-$minute";
}
extension TimeOfDayExtension on TimeOfDay {
  String get  toShortDate => "$hour-$minute";
}

extension NullableTimeOfDayExtension on  TimeOfDay? {
  String get toShortDate =>"${this?.hour}-${this?.minute}" ?? "00-00";
}
extension StringTimeofDayExtension on String {
  TimeOfDay get  toTimeOfDay => TimeOfDay(hour: int.parse(split('-').first), minute: int.parse(split('-').last));
}