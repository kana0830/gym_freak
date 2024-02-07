// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_memo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user.dart';
import '../../repositories/training_memo_repository.dart';
import '../../repositories/user_repository.dart';

part 'training_memo_notifier.g.dart';

@riverpod
class TrainingMemoNotifier extends _$TrainingMemoNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late DocumentSnapshot<Map<String, dynamic>> trainingMemo;

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> build() async {
    var trainingMemo = await _trainingMemoRepository.getTrainingMemo();
    return trainingMemo;
  }

  // update
  void updateState(id, value) async {
    _trainingMemoRepository.updateTrainingMemo(id, value);
  }
}