import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sets_notifier.g.dart';

/// 記録管理
@riverpod
class SetsNotifier extends _$SetsNotifier {

  late List<TextEditingController> setsControllerList = [];

  @override
  List<TextEditingController> build() {
    return setsControllerList;
  }

  /// 親画面からのパラメータ設定
  void setState(menus) {
    if (setsControllerList.isEmpty) {
      menus.forEach((menu) {
        setsControllerList.add(TextEditingController());
      });
    }
    state = [...setsControllerList];
  }

  /// sets書き換え
  void updateSetsState(value, index) async {
    setsControllerList[index].text = value;
    state = [...setsControllerList];
  }

  /// 空行追加
  void insertRowState() async {
    setsControllerList.add(TextEditingController());
    state = [...setsControllerList];
  }
}