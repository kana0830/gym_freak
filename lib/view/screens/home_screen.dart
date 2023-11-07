import 'package:flutter/material.dart';
import 'package:gym_freak/view/screens/pages/profile.dart';
import 'package:gym_freak/view/screens/pages/ranking.dart';
import 'package:gym_freak/view/screens/pages/training_memo.dart';
import 'package:gym_freak/view/screens/pages/my_calender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../common/common_data_util.dart';

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
      appBar: _appBar(),
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

  AppBar _appBar() {
    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    final List<Map<String, dynamic>> _pagesAppbar = [
      {
        'title': today,
        'icon': Icon(Icons.add),
      },
      {
        'title': today,
        'icon': Icon(Icons.add),
      },
      {
        'title': today,
        'icon': Container(),
      },
      {
        'title': '花南',
        'icon': Icon(Icons.edit),
      }
  ];

    return AppBar(
      backgroundColor: Color(0xFF7b755e),
      title: Text(_pagesAppbar[_currentIndex]['title']),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(10.0, 10.0),
            backgroundColor: Color(0xFF7b755e),
          ),
          onPressed: () {},
          child: _pagesAppbar[_currentIndex]['icon'],
        )
      ],
    );
  }
}
