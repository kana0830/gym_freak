
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
