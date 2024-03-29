import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/common_data_util.dart';
import '../../models/aurh_service.dart';
import '../../repositories/training_memo_repository.dart';

part 'calender_notifier.g.dart';

@riverpod
class CalenderNotifier extends _$CalenderNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> trainingMemo;

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> build() async {
    return trainingMemo;
  }

  /// 書き換え
  void setState(DateTime day) async {
    var monthString = day.month.toString().length == 1 ? '0' + day.month.toString() : day.month.toString();
    var dayString = day.day.toString().length == 1 ? '0' + day.day.toString() : day.day.toString();
    var dateString = day.year.toString() + monthString + dayString;
    var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + dateString);
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }

  /// update
  void updateState(value) async {

  }
}