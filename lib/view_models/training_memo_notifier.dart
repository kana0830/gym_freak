// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

part 'training_memo_notifier.g.dart';

@riverpod
class TrainingMemoNotifier extends _$TrainingMemoNotifier {
  final _userRepository = UserRepository();
  late DocumentSnapshot<Map<String, dynamic>> trainingMemo;

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> build() async {
    var user = await _userRepository.getUser();
    return user;
  }

  // update
  void updateState(id, value) async {
    _userRepository.updateUser(id, value);
  }
}