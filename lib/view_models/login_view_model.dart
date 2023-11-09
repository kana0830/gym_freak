import 'package:flutter/material.dart';

import '../models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({required this.userRepository});

  Future<bool> isSingIn() async {
    return await userRepository.isSingIn();
  }
}