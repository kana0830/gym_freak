import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/views/screens/pages/calender/training_memo_past.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../common/common_data_util.dart';
import '../../../../models/aurh_service.dart';
import '../../../../view_models/training_memo_notifier/calender_notifier.dart';
import '../../../../view_models/training_memo_notifier/calender_part_notifier.dart';
import '../../../../view_models/training_memo_notifier/calender_select_day_notifier.dart';

/// カレンダー画面
class MyCalender extends ConsumerWidget {
  MyCalender({super.key});

  /// 選択中の日付
  late DateTime tapDay = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(calenderNotifierProvider);
    final trainingPart = ref.watch(calenderPartNotifierProvider);

    /// トレーニング記録表示ウィジェット
    Widget trainingMemoInfo;

    /// トレーニング部位表示ウィジェット
    Widget trainingPartInfo;

    if (trainingPart.hasValue) {
      /// トレーニング部位表示部分
      trainingPartInfo = trainingPart.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) {
          if (data.isEmpty) {
            return const Text("");
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.accessibility,
                    color: Colors.black87,
                    size: 26.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      data.values
                          .toString()
                          .replaceAll("(", "")
                          .replaceAll(")", ""),
                      style: const TextStyle(
                          color: Colors.black87, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      );
    } else {
      return const Text("");
    }

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
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingMemoPast(
                        tapDay: tapDay,
                        menus: menus,
                        trainingPart: trainingPart,
                      ),
                    ),
                  );
                },
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for (var menu in data)
                        ListTile(
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
                                    Text((menu.data()['memo'][i]['weight'] ==
                                                '') &&
                                            (menu.data()['memo'][i]['reps'] ==
                                                '') &&
                                            (menu.data()['memo'][i]['sets'] == '')
                                        ? ''
                                        : "・"),
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
                                    Text(menu.data()['memo'][i]['reps'] == ''
                                        ? ''
                                        : 'rep'),
                                    Text(
                                      menu.data()['memo'][i]['sets'] == ''
                                          ? ''
                                          : '×',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text('${menu.data()['memo'][i]['sets']}'),
                                    Text(menu.data()['memo'][i]['sets'] == ''
                                        ? ''
                                        : 'set'),
                                  ],
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      );

      /// トレーニング記録がない場合
    } else {
      trainingMemoInfo = Container();
    }

    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 300,
              child: TableCalendar(
                currentDay: tapDay,
                headerStyle: const HeaderStyle(
                  headerPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF7b755e),
                  ),
                  formatButtonVisible: false,
                  titleCentered: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                focusedDay: tapDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                shouldFillViewport: true,
                locale: 'ja_JP',
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 30,
                calendarStyle: CalendarStyle(
                  tableBorder: TableBorder.all(
                      color: const Color(0xff848375), width: 0.4),
                ),
                calendarBuilders: CalendarBuilders(
                  /// ヘッダ部分
                  dowBuilder: (_, day) {
                    return Container(
                      color: const Color(0xFFFFF9C4),
                      child: Center(
                        child: Text(
                          _dayOfWeek(day),
                          style: TextStyle(color: _textColor(day)),
                        ),
                      ),
                    );
                  },

                  /// デフォルト
                  defaultBuilder: (BuildContext context, DateTime day,
                      DateTime focusedDay) {
                    return AnimatedContainer(
                      color: Colors.white,
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

                  /// 今日
                  todayBuilder: (BuildContext context, DateTime day,
                      DateTime focusedDay) {
                    return AnimatedContainer(
                      color: Colors.white,
                      duration: const Duration(milliseconds: 250),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFffe071),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(
                                color: _textColor(day),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (BuildContext context, DateTime day,
                      DateTime focusedDay) {
                    return AnimatedContainer(
                      color: const Color(0xFFE0E0E0),
                      duration: const Duration(milliseconds: 250),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  focusedDay = focusedDay;
                  tapDay = focusedDay;
                  final notifier = ref.read(calenderNotifierProvider.notifier);
                  notifier.setState(selectedDay);
                  final partNotifier =
                      ref.read(calenderPartNotifierProvider.notifier);
                  partNotifier.setState(AuthService.userId +
                      CommonDataUtil.changeDateNoSlash(selectedDay));
                  final selectDayNotifier =
                      ref.read(calenderSelectDayNotifierProvider.notifier);
                  selectDayNotifier.setState(selectedDay);
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              color: const Color(0xFFFFF9C4),
              child: trainingPartInfo,
            ),
            Expanded(child: trainingMemoInfo),
          ],
        ),
      ),
    );
  }

  Color _textColor(DateTime day) {
    const defaultTextColor = Colors.black87;
    switch (day.weekday) {
      case 6:
        return Colors.blue[600]!;
      case 7:
        return Colors.red;
      default:
        return defaultTextColor;
    }
  }

  String _dayOfWeek(day) {
    switch (day.weekday) {
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
      case 7:
        return '日';
      default:
        return '';
    }
  }
}
