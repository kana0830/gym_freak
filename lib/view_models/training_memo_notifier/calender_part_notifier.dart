import 'dart:core';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../common/common_data_util.dart';
import '../../repositories/training_memo_repository.dart';

part 'calender_part_notifier.g.dart';

@riverpod
class CalenderPartNotifier extends _$CalenderPartNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late Map<String, dynamic> trainingPart;

  @override
  Future<Map<String, dynamic>> build() async {
    var trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash());
    return trainingPart;
  }

  /// 書き換え
  void setState(DateTime day) async {
    var monthString = day.month.toString().length == 1 ? '0${day.month}' : day.month.toString();
    var dayString = day.day.toString().length == 1 ? '0${day.day}' : day.day.toString();
    var dateString = day.year.toString() + monthString + dayString;
    var trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + dateString);
    state = AsyncData<Map<String, dynamic>>(trainingPart);
  }

  // update
  void updateState(userIdKye, value) async {
    _trainingMemoRepository.updateTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash(), value);
    trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash());
    state = AsyncData<Map<String, dynamic>>(trainingPart);
  }
}