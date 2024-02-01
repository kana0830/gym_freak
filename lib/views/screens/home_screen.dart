import 'package:flutter/material.dart';
import 'package:gym_freak/views/screens/pages/edit_profile.dart';
import 'package:gym_freak/views/screens/pages/profile.dart';
import 'package:gym_freak/views/screens/pages/ranking.dart';
import 'package:gym_freak/views/screens/pages/training_memo.dart';
import 'package:gym_freak/views/screens/pages/my_calender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../common/common_data_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // ナビゲーションバーに表示するページ
  final _pages = [
    const TrainingMemo(),
    const MyCalender(),
    // Ranking(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFFF176),
        unselectedItemColor: const Color(0xFF757575),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: '記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'カレンダー',
          ),
          // TODO ランキング機能いずれ追加したい
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_chart),
          //   label: 'ランキング',
          // ),
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
