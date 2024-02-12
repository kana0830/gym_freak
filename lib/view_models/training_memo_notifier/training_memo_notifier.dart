// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/common/common_data_util.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_memo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user.dart';
import '../../repositories/training_memo_repository.dart';
import '../../repositories/user_repository.dart';

part 'training_memo_notifier.g.dart';

@riverpod
class TrainingMemoNotifier extends _$TrainingMemoNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> trainingMemo;

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> build() async {
    // var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + CommonDataUtil.getDateNoSlash());
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + '20240211');
    return trainingMemo;
  }

  // update
  void updateState(userIdKye, value) async {
    _trainingMemoRepository.updateTrainingMemo(userIdKye, value);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + '20240211');
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }
}