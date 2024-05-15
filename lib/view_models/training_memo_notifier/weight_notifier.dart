import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weight_notifier.g.dart';

/// 記録管理
@riverpod
class WeightNotifier extends _$WeightNotifier {

  late List<TextEditingController> weightControllerList = [];

  @override
  List<TextEditingController> build() {
    return weightControllerList;
  }

  /// 親画面からのパラメータ設定
  void setState(menus) {
    if (weightControllerList.isEmpty) {
      menus.forEach((menu) {
        weightControllerList.add(TextEditingController());
      });
    }
    state = [...weightControllerList];
  }
  // /// list行追加
  // void insertRowState() async {
  //   Map<String, dynamic> emptyMap = {
  //     'weight' : '',
  //     'reps' : '',
  //     'sets' : ''
  //   };
  //   menuList.add(emptyMap);
  //   state = [...menuList];
  // }
  /// weight書き換え
  void updateWeightState(value, index) async {
    weightControllerList[index].text = value;
    state = [...weightControllerList];
  }
  // /// reps書き換え
  // void updateRepsState(value, i) async {
  //   if (menuList.isEmpty) {
  //     menuList.add({});
  //   }
  //   menuList[i]['reps'] = value;
  //   state = [...menuList];
  // }
  // /// sets書き換え
  // void updateSetsState(value, i) async {
  //   if (menuList.isEmpty) {
  //     menuList.add({});
  //   }
  //   menuList[i]['sets'] = value;
  //   state = [...menuList];
  // }
  //
  // /// delete
  // void deleteMenuState(i) async {
  //   menuList.removeAt(i);
  //   state = [...menuList];
  //   if (menuList.isEmpty) {
  //     insertRowState();
  //     // updateWeightState('', 0);
  //     // updateRepsState('', 0);
  //     // updateSetsState('', 0);
  //   }
  //   // state = [...menuList];
  // }
}