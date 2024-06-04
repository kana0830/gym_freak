
class Gender {
  Gender(this.key, this.gender);

  int key;
  String gender;
}

const Map<int, String> genderDiv = {
  1 : '男性',
  2 : '女性',
  3 : 'その他',
  4 : '回答しない',
};

class TrainingTimes {
  TrainingTimes(this.key, this.times);
  int key;
  String times;
}

const Map<int, String> trainingTimesDiv = {
  1 : '1',
  2 : '2',
  3 : '3',
  4 : '4',
  5 : '5',
  6 : '6',
  7 : '7',
};

class WeekOrMonth {
  WeekOrMonth(this.key, this.weekOrMonth);
  int key;
  String weekOrMonth;
}

const Map<int, String> weekOrMonthDiv = {
  1 : '週',
  2 : '月',
};

/// テキストカラー
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

/// 曜日取得
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