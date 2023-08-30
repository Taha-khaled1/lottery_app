import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  String period = timeOfDay.hour >= 12 ? 'PM' : 'AM';
  int hour = timeOfDay.hourOfPeriod;
  int minute = timeOfDay.minute;
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
}
