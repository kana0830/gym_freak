// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../repositories/training_memo_repository.dart';

part 'training_memo_notifier.g.dart';

@riverpod
class TrainingMemoNotifier extends _$TrainingMemoNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> trainingMemo;

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> build() async {
    // var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + CommonDataUtil.getDateNoSlash());
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(
        AuthService.userId + '20240211');
    return trainingMemo;
  }

  // update
  void updateState(userId, menuId, menus) async {
    _trainingMemoRepository.updateTrainingMemo(userId, menuId, menus);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + '20240211');
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }

  // delete
  void deleteMenuState(userId, menuId, i) async {
    _trainingMemoRepository.deleteTrainingMemo(userId, menuId, i);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + '20240211');
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }
}