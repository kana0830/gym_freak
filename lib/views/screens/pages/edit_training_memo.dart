import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/common_data_util.dart';
import 'edit_profile.dart';

// トレーニング編集画面
class EditTrainingMemo extends ConsumerWidget {
  EditTrainingMemo({
    super.key,
  });

  Map<String, dynamic>? userData = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userNotifierProvider);

    // ユーザー情報表示部分
    // final userInfo = user.when(
    //   loading: () => const CircularProgressIndicator(),
    //   error: (error, stacktrace) => Text('エラー $error'),
    //   data: (data) => Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       const Text('名前'),
    //       _textField(1, userData?['userName'], 1),
    //       const Text('性別'),
    //       _selectField(ref, context),
    //       const Text('生年月日'),
    //       _birthDayField(context, data, ref),
    //       const Text('職業'),
    //       _textField(1, userData?['job'], 2),
    //       const Text('自己紹介'),
    //       _textField(5, userData?['introduction'], 3),
    //       const Text('好きな種目'),
    //       _textField(1, userData?['favoriteMenu'], 4),
    //       const Text('トレーニング回数'),
    //       _trainingTimesField(ref),
    //       const Text('大会実績'),
    //       _textField(1, userData?['tournamentResults'], 5),
    //     ],
    //   ),
    // );

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('場所'),
                _textField(1, 'Forza神田'),
                const Text('日時'),
                _dateAndTime(context, '2020-11-12', ref),
                const Text('部位'),
                _textField(1, '胸/肩'),
                _trainingMenu(),
              ],
            ),
          ),
        ),
      ),
    );
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
              Container(
                  child: Column(
                children: [
                  const Text('種目'),
                  _textField(1, 'ベンチプレス'),
                ],
              )),
              Row(
                children: [
                  Column(
                    children: [
                      const Text('重量'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(width: 100, child: _textField(1, '20kg')),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, bottom: 8.0),
                            child: Text('kg'),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 18.0),
                    child: Text('×', style: TextStyle(fontSize: 40.0)),
                  ),
                  Container(
                      width: 100,
                      child: Column(
                        children: [
                          const Text('Rep'),
                          _textField(1, '10'),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ));
  }

  // 入力欄
  Widget _textField(int lines, initValue) {
    return Card(
      child: TextField(
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
