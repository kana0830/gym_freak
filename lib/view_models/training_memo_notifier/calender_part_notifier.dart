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
  void setState(String userIdKey) async {
    var trainingPart = await _trainingMemoRepository.getTrainingPart(userIdKey);
    state = AsyncData<Map<String, dynamic>>(trainingPart);
  }

  /// update
  void updateState(DateTime day, value) async {
    _trainingMemoRepository.updateTrainingPart(AuthService.userId + CommonDataUtil.changeDateNoSlash(day), value);
    trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.changeDateNoSlash(day));
    state = AsyncData<Map<String, dynamic>>(trainingPart);
  }
}