// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/aurh_service.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';

part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {

  final _userRepository = UserRepository();
  late QueryDocumentSnapshot<Map<String, dynamic>> user;

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> build() async {
    var user = await _userRepository.getUser(AuthService.email);
    return user;
  }

  // update
  void updateState(value) async {
    _userRepository.updateUser(value);
  }
}