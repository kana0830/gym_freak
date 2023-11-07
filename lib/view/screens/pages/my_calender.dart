import 'package:flutter/material.dart';

class MyCalender extends StatefulWidget {
  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(child: Text("mycarender"),),
        ),
      ),
    );
  }
}


