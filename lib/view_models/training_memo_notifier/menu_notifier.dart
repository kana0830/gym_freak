// ignore_for_file: avoid_public_notifier_properties
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_notifier.g.dart';

@riverpod
class MenuNotifier extends _$MenuNotifier {

  QueryDocumentSnapshot<Map<String, dynamic>>? menu;
  late List<Map<String, dynamic>> menuList = [];

  @override
  List<Map<String, dynamic>> build() {
    return [];
  }

  // 親画面からのパラメータ設定
  void setState(QueryDocumentSnapshot<Map<String, dynamic>>? menu) {
    if (menuList.isEmpty){
      for(var memo in menu?.data()['memo']) {
        menuList.add(memo);
      }
      state = menuList;
    }
  }

  // weight書き換え
  void updateWeightState(value, i) async {
    menuList[i]['weight'] = value;
    state = menuList;
  }
  // reps書き換え
  void updateRepsState(value, i) async {
    menuList[i]['reps'] = value;
    state = menuList;
  }
  // sets書き換え
  void updateSetsState(value, i) async {
    menuList[i]['sets'] = value;
    state = menuList;
  }

  // delete
  void deleteMenuState(i) async {
    menuList.removeRange(i, i+1);
    state = menuList;
  }
}