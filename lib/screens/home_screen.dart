import 'package:flutter/material.dart';
import 'package:gym_freak/screens/pages/profile.dart';
import 'package:gym_freak/screens/pages/ranking.dart';
import 'package:gym_freak/screens/pages/training_memo.dart';
import 'package:gym_freak/screens/pages/my_calender.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = [
    TrainingMemo(),
    MyCalender(),
    Ranking(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
          ),
        ],
      ),
    ));
  }
}
