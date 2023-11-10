import 'dart:js';

import 'package:flutter/material.dart';
import 'package:gym_freak/models/db/database_manager.dart';
import 'package:gym_freak/models/repositories/user_repository.dart';
import 'package:gym_freak/view_models/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) =>
        LoginViewModel(userRepository: context.read<UserRepository>()),
  ),
];