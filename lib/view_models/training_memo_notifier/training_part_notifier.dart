// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/common/common_data_util.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_memo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user.dart';
import '../../repositories/training_memo_repository.dart';
import '../../repositories/user_repository.dart';

part 'training_part_notifier.g.dart';

@riverpod
class TrainingPartNotifier extends _$TrainingPartNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late DocumentSnapshot<Map<String, dynamic>> trainingMemo;

  @override
  Future<Map<String, dynamic>> build() async {
    var trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash());
    return trainingPart;
  }

  // update
  void updateState(id, value) async {
    _trainingMemoRepository.updateTrainingMemo(id, value);
  }
}