import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/common_data_util.dart';

// カレンダー画面
class MyCalender extends StatefulWidget {
  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  @override
  Widget build(BuildContext context) {

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    DateTime focusedDay = DateTime.now();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7b755e),
      title: Text(today),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(10.0, 10.0),
            backgroundColor: const Color(0xFF7b755e),
          ),
          onPressed: () {
          },
          child: const Icon(Icons.add),
        )
      ],
    ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFFFFFDE7), width: 1.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 380,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TableCalendar(
                    focusedDay: focusedDay,
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2024, 12, 31),
                    shouldFillViewport: true,
                    locale: 'ja_JP',
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    daysOfWeekHeight: 30,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      headerPadding: EdgeInsets.all(6.0),
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      titleTextStyle:
                          TextStyle(color: Color(0xFFFFFDE7), fontSize: 18.0),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: Color(0xFFFAFAFA),
                      ),
                      weekendStyle: TextStyle(
                        color: Color(0xFF9FA8DA),
                      ),
                    ),
                    calendarStyle: const CalendarStyle(
                      weekendTextStyle: TextStyle(
                        color: Color(0xFF9FA8DA),
                      ),
                      outsideTextStyle: TextStyle(
                        color: Color(0xFF616161),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
