// ignore_for_file: avoid_public_notifier_properties
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/common/common_data_util.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_memo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user.dart';
import '../../repositories/training_memo_repository.dart';
import '../../repositories/user_repository.dart';

part 'menu_notifier.g.dart';

@riverpod
class MenuNotifier extends _$MenuNotifier {
  MenuNotifier({this.menu});
  QueryDocumentSnapshot<Map<String, dynamic>>? menu;
  late List<Map<String, dynamic>> menuList = [];

  @override
  List<Map<String, dynamic>> build() {
    for(var memo in menu?.data()['memo']) {
      menuList.add(memo);
    }
    return menuList;
  }

  // // update
  // void setState(QueryDocumentSnapshot<Map<String, dynamic>>? menu) {
  //   for(var memo in menu?.data()['memo']) {
  //     this.menu.add(memo);
  //   }
  //   state = this.menu;
  // }

  // update
  void updateState(userId, menuId, menus) async {
  }

  // delete
  void deleteMenuState(userId, menuId, i) async {
  }
}