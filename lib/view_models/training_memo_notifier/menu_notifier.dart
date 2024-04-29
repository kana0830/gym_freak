import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_notifier.g.dart';

/// 記録管理
@riverpod
class MenuNotifier extends _$MenuNotifier {

  QueryDocumentSnapshot<Map<String, dynamic>>? menu;
  late List<Map<String, dynamic>> menuList = [];


  @override
  List<Map<String, dynamic>> build() {
    return [];
  }

  /// 親画面からのパラメータ設定
  void setState(QueryDocumentSnapshot<Map<String, dynamic>>? menu) {
    if (menuList.isEmpty){
      if(menu != null) {
        for(var memo in menu.data()['memo']) {
          menuList.add(memo);
        }
      } else {
        Map<String, dynamic> emptyMap = {
          'weight' : '',
          'reps' : '',
          'sets' : ''
        };
        menuList.add(emptyMap);
      }
      state = [...menuList];
    }
  }
  /// list行追加
  void insertRowState() async {
    Map<String, dynamic> emptyMap = {
      'weight' : '',
      'reps' : '',
      'sets' : ''
    };
    menuList.add(emptyMap);
    state = [...menuList];
  }
  /// weight書き換え
  void updateWeightState(value, i) async {
    if (menuList.isEmpty) {
      menuList.add({});
    }
    menuList[i]['weight'] = value;
    state = [...menuList];
  }
  /// reps書き換え
  void updateRepsState(value, i) async {
    if (menuList.isEmpty) {
      menuList.add({});
    }
    menuList[i]['reps'] = value;
    state = [...menuList];
  }
  /// sets書き換え
  void updateSetsState(value, i) async {
    if (menuList.isEmpty) {
      menuList.add({});
    }
    menuList[i]['sets'] = value;
    state = [...menuList];
  }

  /// delete
  void deleteMenuState(i) async {
    menuList.removeAt(i);
    state = [...menuList];
    if (menuList.isEmpty) {
      insertRowState();
      // updateWeightState('', 0);
      // updateRepsState('', 0);
      // updateSetsState('', 0);
    }
    // state = [...menuList];
  }
}