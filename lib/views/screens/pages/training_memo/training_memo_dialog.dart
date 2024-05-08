import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/common/appColors.dart';
import '../../../../common/common_data_util.dart';
import '../../../../models/aurh_service.dart';
import '../../../../view_models/training_memo_notifier/calender_memo_notifier.dart';
import '../../../../view_models/training_memo_notifier/menu_id_notifier.dart';
import '../../../../view_models/training_memo_notifier/menu_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';

/// トレーニング記録登録ダイアログ
class TrainingMemoDialog extends ConsumerWidget {
  TrainingMemoDialog(
      {this.menus,
      this.menuId,
      required this.createdAt,
      required this.edit,
      required this.data,
      super.key});

  /// メニュー
  QueryDocumentSnapshot<Map<String, dynamic>>? menus;

  /// メニューID
  String? menuId = '';

  /// 登録日時
  DateTime? createdAt;

  /// 編集フラグ
  int edit;

  /// 日付
  DateTime data;

  /// ユーザーIDキー
  String userIdKey = AuthService.userId + CommonDataUtil.getDateNoSlash();
  String text = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// ユーザーIDキー
    String userIdKey =
        AuthService.userId + CommonDataUtil.changeDateNoSlash(data);

    /// メニュー
    final menu = ref.watch(menuNotifierProvider);

    /// メニューID
    final menuId = ref.watch(menuIdNotifierProvider);

    /// メニューデータをセットして書き換え
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(menuNotifierProvider.notifier);
      notifier.setState(menus);
    });

    /// メニューIDデータがある場合、メニューIDデータをセットして書き換え
    if (this.menuId != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(menuIdNotifierProvider.notifier);
        notifier.setState(this.menuId);
      });
    }

    ///　スクリーンサイズ取得
    var screenSize = MediaQuery.of(context).size;

    /// トレーニング記録ダイアログ
    return Dialog(
      insetPadding: const EdgeInsets.all(20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenSize.height * 0.2,
          maxHeight: screenSize.height * 0.6,
        ),
        child: Card(
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFFFF59D), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                /// 記録の表示
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 種目名の表示
                    edit == 0 ? const Text('種目') : Container(),
                    edit == 0
                        ? Card(
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              initialValue: menuId,
                              decoration: const InputDecoration(
                                floatingLabelStyle:
                                    TextStyle(color: Colors.white),
                                filled: true,
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                final notifier =
                                    ref.read(menuIdNotifierProvider.notifier);
                                notifier.updateState(value);
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              menuId,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Color(0xFFFFF59D)),
                            ),
                          ),

                    /// 記録入力のタイトル
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Text('重量'),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text('回数'),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text('セット数'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// 記録入力リスト
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    children: [
                      _updateWidget(ref, menu),
                    ],
                  ),
                ),

                /// 登録更新ボタン
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                    ),
                    onPressed: () {
                      var now = DateTime.now();
                      var nowDate = DateTime(now.year, now.month, now.day);
                      var tapDate = DateTime(data.year, data.month, data.day);
                      if (tapDate.isAtSameMomentAs(nowDate)) {
                        final notifier =
                            ref.read(trainingMemoNotifierProvider.notifier);
                        notifier.updateState(userIdKey, menuId, menu, createdAt);
                      } else {
                        final notifier =
                            ref.read(calenderMemoNotifierProvider.notifier);
                        notifier.updateState(userIdKey, menuId, menu, createdAt);
                      }

                      Navigator.pop(context);
                    },
                    child: Text(
                      edit == 0 ? '登録' : '更新',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 更新用記録入力ウィジェット
  Widget _updateWidget(ref, menu) {
    return Column(
      children: [
        for (int i = 0; i < menu.length; i++)
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Card(
                  child: TextFormField(
                      textAlign: TextAlign.end,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialValue: text = menu[i]['weight'],
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final notifier =
                            ref.read(menuNotifierProvider.notifier);
                        notifier.updateWeightState(value, i);
                      }),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text('kg'),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  '×',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 4,
                child: Card(
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    initialValue: menu[i]['reps'],
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final notifier = ref.read(menuNotifierProvider.notifier);
                      notifier.updateRepsState(value, i);
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text('rep'),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  '×',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 4,
                child: Card(
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    initialValue: menu[i]['sets'],
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final notifier = ref.read(menuNotifierProvider.notifier);
                      notifier.updateSetsState(value, i);
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text('set'),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                  icon: const Icon(Icons.highlight_off),
                  onPressed: () {
                    /// 記録枠が１行の場合
                    if (menu.length == 1) {
                      final notifier = ref.read(menuNotifierProvider.notifier);
                      notifier.deleteMenuState(0);
                    } else {
                      final notifier = ref.read(menuNotifierProvider.notifier);
                      notifier.deleteMenuState(i);
                    }
                  },
                ),
              )
            ],
          ),
        SizedBox(
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.insertRowState();
            },
            child: const Text('セット数追加'),
          ),
        ),
      ],
    );
  }
}
