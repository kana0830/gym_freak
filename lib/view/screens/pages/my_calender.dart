import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalender extends StatefulWidget {
  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.now(),
                lastDay: DateTime.now(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
