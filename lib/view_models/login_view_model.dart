import 'package:flutter/material.dart';

import '../models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepositry;
  LoginViewModel({required this.userRepositry});
}