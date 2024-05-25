import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weight_notifier.g.dart';

/// weight管理
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

  /// weight書き換え
  void updateWeightState(value, index) async {
    weightControllerList[index].text = value;
    state = [...weightControllerList];
  }

  /// 空行追加
  void insertRowState() async {
    weightControllerList.add(TextEditingController());
    state = [...weightControllerList];
  }
}