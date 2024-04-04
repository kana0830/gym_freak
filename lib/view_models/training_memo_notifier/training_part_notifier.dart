// ignore_for_file: avoid_public_notifier_properties
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../common/common_data_util.dart';
import '../../repositories/training_memo_repository.dart';
import '../../repositories/user_repository.dart';

part 'training_part_notifier.g.dart';

@riverpod
class TrainingPartNotifier extends _$TrainingPartNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late Map<String, dynamic> trainingPart;

  @override
  Future<Map<String, dynamic>> build() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userRepository = UserRepository();
    QueryDocumentSnapshot<Map<String, dynamic>> user =
    await userRepository.getUser(currentUser!.email!);
    AuthService.userId = user.id;
    var trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash());
    return trainingPart;
  }

  // update
  void updateState(userIdKye, value) async {
    _trainingMemoRepository.updateTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash(), value);
    trainingPart = await _trainingMemoRepository.getTrainingPart(AuthService.userId + CommonDataUtil.getDateNoSlash());
    state = AsyncData<Map<String, dynamic>>(trainingPart);
  }
}