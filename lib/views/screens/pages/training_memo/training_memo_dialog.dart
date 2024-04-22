import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/common_data_util.dart';
import '../../../../models/aurh_service.dart';
import '../../../../view_models/training_memo_notifier/calender_memo_notifier.dart';
import '../../../../view_models/training_memo_notifier/menu_id_notifier.dart';
import '../../../../view_models/training_memo_notifier/menu_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';

/// トレーニング記録登録ダイアログ
class TrainingMemoDialog extends ConsumerWidget {
  TrainingMemoDialog({this.menu, this.menuId, required this.edit, required this.data, super.key});

  /// メニュー
  QueryDocumentSnapshot<Map<String, dynamic>>? menu;
  /// メニューID
  String? menuId = '';
  /// 編集フラグ
  int edit;
  /// 日付
  DateTime data;
  /// ユーザーIDキー
  String userIdKey = AuthService.userId + CommonDataUtil.getDateNoSlash();

  var text = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// ユーザーIDキー
    String userIdKey = AuthService.userId + CommonDataUtil.changeDateNoSlash(data);

    /// メニュー
    final menu = ref.watch(menuNotifierProvider);
    /// メニューID
    final menuId = ref.watch(menuIdNotifierProvider);

    /// メニューデータをセットして書き換え
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(menuNotifierProvider.notifier);
      notifier.setState(this.menu);
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
          minHeight: screenSize.height * 0.4,
          maxHeight: screenSize.height * 0.6,
        ),
        child: Card(
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFFFF176), width: 1),
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
                        ? _textField(1, menuId, 0, 0, ref)
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
                      backgroundColor: const Color(0xFFFFF59D),
                    ),
                    onPressed: () {
                      var now = DateTime.now();
                      var nowDate = DateTime(now.year, now.month, now.day);
                      var tapDate = DateTime(data.year, data.month, data.day);
                      if(tapDate.isAtSameMomentAs(nowDate)) {
                        final notifier =
                        ref.read(trainingMemoNotifierProvider.notifier);
                        notifier.updateState(userIdKey, menuId, menu);
                      } else {
                        final notifier =
                        ref.read(calenderMemoNotifierProvider.notifier);
                        notifier.updateState(userIdKey, menuId, menu);
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
                    // initialValue: text = menu[i]['weight'],
                    controller: TextEditingController(text: text = menu[i]['weight']),
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final notifier = ref.read(menuNotifierProvider.notifier);
                      notifier.updateWeightState(value, i);
                    }
                  ),
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
                    // initialValue: text = menu[i]['reps'],
                    controller: TextEditingController(text: text = menu[i]['reps']),
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
                    // initialValue: text = menu[i]['sets'],
                    controller: TextEditingController(text: text = menu[i]['sets']),
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
                    if(menu.length == 1) {
                      final notifier = ref.read(menuNotifierProvider.notifier);
                      notifier.updateWeightState('', i);
                      notifier.updateRepsState('', i);
                      notifier.updateSetsState('', i);
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
              final notifier =
              ref.read(menuNotifierProvider.notifier);
              notifier.insertRowState();
            },
            child: const Text('セット数追加'),
            ),
          ),
      ],
    );
  }

  /// 入力欄
  Widget _textField(int no, dynamic menu, int edit, int i, ref) {

    switch (no) {
      case 1:
        text = menu;
        break;
      case 2: /// weight
        if (menu.length == 0) {
          text = '';
        } else {
          text = menu[i]['weight'];
        }
        break;
      case 3: /// reps
        if (menu.length == 0) {
          text = '';
        } else {
          text = menu[i]['reps'];
          break;
        }
      case 4: ///sets
        if (menu.length == 0) {
          text = '';
        } else {
          text = menu[i]['sets'];
          break;
        }
    }

    return Card(
      child: TextFormField(
        textAlign: no == 1 ? TextAlign.start : TextAlign.end,
        // initialValue: text,
        controller: TextEditingController(text: formKey.toString()),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        keyboardType: no == 1 ? TextInputType.text : TextInputType.number,
        onChanged: (value) {
          switch (no) {
            case 1:
              final notifier = ref.read(menuIdNotifierProvider.notifier);
              notifier.updateState(value);
              break;
            case 2: /// weight
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.updateWeightState(value, i);
              break;
            case 3: /// reps
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.updateRepsState(value, i);
              break;
            case 4: ///sets
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.updateSetsState(value, i);
              break;
          }
        },
      ),
    );
  }
}
