import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/common_data_util.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';
import '../profile/edit_profile.dart';

// トレーニング編集画面
class EditTrainingMemo extends ConsumerWidget {
  EditTrainingMemo({
    this.trainingMemoData,
    super.key,
  });

  Map<String, dynamic>? trainingMemoData = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingMemo = ref.watch(trainingMemoNotifierProvider);

    // ユーザー情報表示部分
    final trainingMemoInfo = trainingMemo.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stacktrace) => Text('エラー $error'),
      data: (data) => Dialog(

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('種目'),
                        _textField(1, 'ベンチプレス', 0),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            const Text('重量'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: _textField(1, '20', 1),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                                  child: Text('kg'),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding:
                          const EdgeInsets.only(left: 4.0, right: 4.0, top: 18.0),
                          child: const Text('×', style: TextStyle(fontSize: 20.0)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Column(
                                children: [
                                  const Text('Rep'),
                                  _textField(1, '10', 1),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                              child: Text('rep'),
                            ),
                          ],
                        ),Container(
                          padding:
                          const EdgeInsets.only(left: 4.0, right: 4.0, top: 18.0),
                          child: const Text('×', style: TextStyle(fontSize: 20.0)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Column(
                                children: [
                                  const Text('Set'),
                                  _textField(1, '10', 1),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                              child: Text('set'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
    );

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    // プロフィール画面
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7b755e),
          title: const Text('トレーニング記録'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(10.0, 10.0),
                backgroundColor: const Color(0xFF7b755e),
              ),
              onPressed: () {},
              child: const Text('保存'),
            )
          ],
        ),
        body: trainingMemoInfo
      ),
    );
  }

  Future trainingMemoDialog(BuildContext context) async {
    // (2) showDialogでダイアログを表示する
    var ret = await showDialog(
        context: context,
        // (3) AlertDialogを作成する
        builder: (context) => Dialog(

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('種目'),
                      _textField(1, 'ベンチプレス', 0),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text('重量'),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 60,
                                child: _textField(1, '20', 1),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                                child: Text('kg'),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding:
                        const EdgeInsets.only(left: 4.0, right: 4.0, top: 18.0),
                        child: const Text('×', style: TextStyle(fontSize: 20.0)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text('Rep'),
                                _textField(1, '10', 1),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                            child: Text('rep'),
                          ),
                        ],
                      ),Container(
                        padding:
                        const EdgeInsets.only(left: 4.0, right: 4.0, top: 18.0),
                        child: const Text('×', style: TextStyle(fontSize: 20.0)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text('Set'),
                                _textField(1, '10', 1),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                            child: Text('set'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
    // (6) ダイアログが閉じたときの結果
    if(ret != null) {
      if (ret == true) {
        print("---- YES -----");
      }
      else {
        print("---- NO -----");
      }
    }
    else{
      //  (7) 選択せずに閉じた場合
      print("---- NULL ----");
    }
  }

  // トレーニング種目
  Widget _trainingMenu() {
    return Card(
      shadowColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFFFF176), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('種目'),
                _textField(1, 'ベンチプレス', 0),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    const Text('重量'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 100,
                          child: _textField(1, '20', 1),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 2.0, bottom: 8.0),
                          child: Text('kg'),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 18.0),
                  child: const Text('×', style: TextStyle(fontSize: 40.0)),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      const Text('Rep'),
                      _textField(1, '10', 1),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 入力欄
  Widget _textField(int lines, initValue, int alignFlg) {
    return Card(
      child: TextField(
        textAlign: alignFlg == 1 ? TextAlign.end : TextAlign.start,
        controller: TextEditingController(text: initValue),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        maxLines: lines,
        onChanged: (value) {},
      ),
    );
  }

  // 日時フォーム
  Widget _dateAndTime(context, data, ref) {
    // var bdData = data['birthday'].toDate();
    // var initBD = DateFormat('yyyy/MM/dd')
    //     .format(bdData)
    //     .toString();
    return Row(
      children: [
        _dateAndTimeField(context, data, ref),
        const Text('〜'),
        _dateAndTimeField(context, data, ref),
      ],
    );
  }

  // 日時入力
  Widget _dateAndTimeField(context, data, ref) {
    return SizedBox(
      width: 170.0,
      child: Card(
        child: TextFormField(
          controller: TextEditingController(text: data),
          focusNode: AlwaysDisabledFocusNode(),
          decoration: const InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.white),
            filled: true,
            border: InputBorder.none,
          ),
          onTap: () {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onConfirm: (date) {
              // userData?['birthday'] = date.toString();
              // initBD = userData?['birthday'];
              // final notifier = ref.read(userNotifierProvider.notifier);
              // notifier.rewriting();
            },
                minTime: DateTime(1960, 1, 1),
                maxTime: DateTime(2025, 12, 31),
                // currentTime: DateTime(bdData.year, bdData.month, bdData.day),
                locale: LocaleType.jp);
          },
        ),
      ),
    );
  }
}
