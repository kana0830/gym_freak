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
  late Map<String, dynamic> trainingPart;

  @override
  Future<Map<String, dynamic>> build() async {
    // var trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash());
    trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + '20240211');
    return trainingPart;
  }

  // update
  void updateState(userIdKye, value) async {
    _trainingMemoRepository.updateTrainingPart(AuthService.userId + '20240211', value);
    trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + '20240211');
    state = AsyncData<Map<String, dynamic>>(trainingPart);
  }
}