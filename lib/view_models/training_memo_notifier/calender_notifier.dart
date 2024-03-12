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
  String build() {
    return '';
  }

  /// set
  void setState(DateTime day) async {
    var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + day.toString());
  }

  /// update
  void updateState(value) async {

  }
}