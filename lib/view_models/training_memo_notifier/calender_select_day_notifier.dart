import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'calender_select_day_notifier.g.dart';

@riverpod
class CalenderSelectDayNotifier extends _$CalenderSelectDayNotifier {

  @override
  DateTime build() {
    return DateTime.now();
  }

  /// 書き換え
  void setState(DateTime day) {
    state = day;
  }
}