import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final _userRepository = UserRepository();
  // Map<String, dynamic> user = {};

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> build() async {
    var user = await _userRepository.getUser();
    return user;
  }

  // update
  void updateState(id, value) async {
    _userRepository.updateUser(id, value);
    var updatedUser = await _userRepository.getUser();
    // user = updatedUser;
    // state = AsyncData<User>(user);
  }
}