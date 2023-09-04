import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';

class TimeDisplay extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;

  TimeDisplay(
      {required this.hours, required this.minutes, required this.seconds});

  Widget _timeBlock(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(
        color: ColorManager.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _timeBlock(hours, "HOURS"),
          VerticalDivider(color: Colors.grey[300], thickness: 1.5),
          _timeBlock(minutes, "MINUTES"),
          VerticalDivider(color: Colors.grey[300], thickness: 1.5),
          _timeBlock(seconds, "SECONDS"),
        ],
      ),
    );
  }
}
