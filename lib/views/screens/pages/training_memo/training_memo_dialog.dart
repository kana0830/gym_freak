import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/common_data_util.dart';
import '../../../../models/aurh_service.dart';
import '../../../../view_models/training_memo_notifier/menu_id_notifier.dart';
import '../../../../view_models/training_memo_notifier/menu_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';

class TrainingMemoDialog extends ConsumerWidget {
  TrainingMemoDialog({this.menu, this.menuId, required this.edit, super.key});

  QueryDocumentSnapshot<Map<String, dynamic>>? menu;
  String? menuId = '';
  int edit;

  // ユーザーIDキー
  String userIdKey = AuthService.userId + CommonDataUtil.getDateNoSlash();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuNotifierProvider);
    final menuId = ref.watch(menuIdNotifierProvider);
    if (this.menu != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(menuNotifierProvider.notifier);
        notifier.setState(this.menu);
      });
    }
    if (this.menuId != null || this.menuId != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(menuIdNotifierProvider.notifier);
        notifier.setState(this.menuId);
      });
    }

    var screenSize = MediaQuery.of(context).size;

    // トレーニング記録ダイアログ
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    edit == 0 ? const Text('種目') : Container(),
                    edit == 0
                        ? _textField(1, menuId, 0, 0, ref)
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              menuId!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Color(0xFFFFF59D)),
                            ),
                          ),
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
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    children: [
                      edit == 0 ? _insertWidget(ref) : _updateWidget(ref, menu),

                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF59D),
                    ),
                    onPressed: () {
                      final notifier =
                          ref.read(trainingMemoNotifierProvider.notifier);
                      notifier.updateState(userIdKey, menuId, menu);
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

  // 登録用記録入力ウィジェット
  Widget _insertWidget(ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: _textField(2, '', 0, 0, ref),
            ),
            const Expanded(
              flex: 2,
              child: Text('kg'),
            ),
            const Expanded(
              flex: 1,
              child: Text('×',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 4,
              child: _textField(3, '', 0, 0, ref),
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
              child: _textField(4, '', 0, 0, ref),
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
                  final notifier = ref.read(menuNotifierProvider.notifier);
                  notifier.deleteMenuState();
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  // 更新用記録入力ウィジェット
  Widget _updateWidget(ref, menu) {
    return Column(
      children: [
        for (int i = 0; i < menu.length; i++)
          Row(
            children: [
              Expanded(
                flex: 4,
                child: _textField(2, menu[i]['weight'], 1, i, ref),
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
                child: _textField(3, menu[i]['reps'], 1, i, ref),
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
                child: _textField(4, menu[i]['sets'], 1, i, ref),
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
                    final notifier = ref.read(menuNotifierProvider.notifier);
                    notifier.deleteMenuState(i);
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
            child: Text('セット数追加'),
            ),
          ),
      ],
    );
  }

  // 入力欄
  Widget _textField(int no, String text, int edit, int i, ref) {
    return Card(
      child: TextFormField(
        textAlign: no == 1 ? TextAlign.start : TextAlign.end,
        initialValue: text,
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          switch (no) {
            case 1:
              final notifier = ref.read(menuIdNotifierProvider.notifier);
              notifier.updateState(value);
              break;
            case 2: // weight
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.updateWeightState(value, i);
              break;
            case 3: // reps
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.updateRepsState(value, i);
              break;
            case 4: //sets
              final notifier = ref.read(menuNotifierProvider.notifier);
              notifier.updateSetsState(value, i);
              break;
          }
        },
      ),
    );
  }
}
