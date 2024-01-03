import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final _userRepository = UserRepository();

  @override
  Future<String> build() async {
    var user = await _userRepository.getUser();
    return user;
  }
}