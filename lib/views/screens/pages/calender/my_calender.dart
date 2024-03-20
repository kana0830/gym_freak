import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../common/common_data_util.dart';
import '../../../../view_models/training_memo_notifier/calender_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_part_notifier.dart';

/// カレンダー画面
class MyCalender extends ConsumerWidget {
  const MyCalender({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(calenderNotifierProvider);
    final trainingPart = ref.watch(trainingPartNotifierProvider);

    /// トレーニング記録表示ウィジェット
    Widget trainingMemoInfo;

    /// 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    /// トレーニング記録がある場合
    if (menus.hasValue) {
      /// トレーニング記録表示部分
      trainingMemoInfo = menus.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) {
          if (data.isEmpty) {
            return Container();
          } else {
            return ListView(
              itemExtent: 50,
              children: [
                for (var menu in data)
                  ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text(
                      menu.id,
                      style: const TextStyle(
                          color: Color(0xFFFFF59D),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      children: [
                        for (int i = 0; i < menu.data()['memo'].length; i++)
                          Row(
                            children: [
                              const Text("・"),
                              Text(menu.data()['memo'][i]['weight']),
                              Text(menu.data()['memo'][i]['weight'] == ''
                                  ? ''
                                  : 'kg'),
                              Text(
                                menu.data()['memo'][i]['weight'] == ''
                                    ? ''
                                    : '×',
                              ),
                              Text('${menu.data()['memo'][i]['reps']}'),
                              const Text('rep'),
                              const Text('×'),
                              Text('${menu.data()['memo'][i]['sets']}'),
                              const Text('set'),
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      );

      /// トレーニング記録がない場合
    } else {
      trainingMemoInfo = Container();
    }

    DateTime focusedDay = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 300,
              child: TableCalendar(
                headerStyle: const HeaderStyle(
                  headerPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                  // decoration: BoxDecoration(
                  //   color: Color(0xFF7b755e),
                  // ),
                  formatButtonVisible: false,
                  titleCentered: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextStyle:
                      TextStyle(color: Color(0xFFFFFDE7), fontSize: 18.0),
                ),
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                shouldFillViewport: true,
                locale: 'ja_JP',
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 30,
                calendarStyle: CalendarStyle(
                    tableBorder: TableBorder.all(color: Color(0xff5f5e53))),
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (_, day) {
                    if (day.weekday == DateTime.sunday) {
                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              // color: Color(0xFFFFF59D),
                              child: Center(
                                child: Text(
                                  '日',
                                  style: TextStyle(color: _textColor(day)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (day.weekday == DateTime.saturday) {
                      return Center(
                        child: Text(
                          '土',
                          style: TextStyle(color: _textColor(day)),
                        ),
                      );
                    }
                    return null;
                  },
                  defaultBuilder: (BuildContext context, DateTime day,
                      DateTime focusedDay) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: _textColor(day),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  final notifier = ref.read(calenderNotifierProvider.notifier);
                  notifier.setState(selectedDay);
                },
              ),
            ),
            Expanded(child: trainingMemoInfo),
          ],
        ),
      ),
    );
  }

  Color _textColor(DateTime day) {
    const _defaultTextColor = Colors.white70;

    if (day.weekday == DateTime.sunday) {
      return Colors.red;
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue[600]!;
    }
    return _defaultTextColor;
  }
}
