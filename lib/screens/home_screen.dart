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
          appBar: AppBar(
            backgroundColor: Color(0xFF7b755e),
            title: Text('花南'),
          ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFFFFF176),
        unselectedItemColor: Color(0xFF757575),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: '記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'カレンダー',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'ランキング',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'マイページ',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    ));
  }
}
