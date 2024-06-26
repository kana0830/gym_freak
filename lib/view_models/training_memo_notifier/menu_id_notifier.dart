import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_id_notifier.g.dart';

/// 部位管理
@riverpod
class MenuIdNotifier extends _$MenuIdNotifier {

  /// メニューID
  String? menuId = '';

  @override
  String build() {
    return '';
  }

  /// 親画面からのパラメータ設定
  void setState(String? menuId) {
    if (this.menuId == ''){
      this.menuId = menuId;
      state = this.menuId!;
    }
  }

  /// menuId書き換え
  void updateState(value) async {
    menuId = value;
    state = menuId!;
  }
}