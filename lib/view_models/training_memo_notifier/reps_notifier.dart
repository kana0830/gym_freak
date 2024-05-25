import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reps_notifier.g.dart';

/// reps管理
@riverpod
class RepsNotifier extends _$RepsNotifier {

  late List<TextEditingController> repsControllerList = [];

  @override
  List<TextEditingController> build() {
    return repsControllerList;
  }

  /// 親画面からのパラメータ設定
  void setState(menus) {
    if (repsControllerList.isEmpty) {
      menus.forEach((menu) {
        repsControllerList.add(TextEditingController());
      });
    }
    state = [...repsControllerList];
  }

  /// reps書き換え
  void updateRepsState(value, index) async {
    repsControllerList[index].text = value;
    state = [...repsControllerList];
  }

  /// 空行追加
  void insertRowState() async {
    repsControllerList.add(TextEditingController());
    state = [...repsControllerList];
  }
}