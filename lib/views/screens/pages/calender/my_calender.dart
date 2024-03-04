import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../common/common_data_util.dart';

/// カレンダー画面
class MyCalender extends StatefulWidget {
  const MyCalender({super.key});

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  @override
  Widget build(BuildContext context) {

    /// 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    DateTime focusedDay = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 300,
              child: TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                shouldFillViewport: true,
                locale: 'ja_JP',
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 30,
                headerStyle: const HeaderStyle(
                  decoration: BoxDecoration(
                    color: Color(0xFF7b755e),
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
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
                // onDaySelected: () {
                //
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
