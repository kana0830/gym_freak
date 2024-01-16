import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/common_data_util.dart';
import '../../../common/division.dart';
import '../../../view_models/user_notifier.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class EditProfile extends ConsumerWidget {
  EditProfile(
    this.userData, {
    super.key,
  });

  Map<String, dynamic>? userData = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    // ユーザー情報表示部分
    final userInfo = user.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stacktrace) => Text('エラー $error'),
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('名前'),
          _textField(1, userData?['userName'], 1),
          const Text('性別'),
          _selectField(ref, context),
          const Text('生年月日'),
          _birthDayField(context, data, ref),
          const Text('職業'),
          _textField(1, userData?['job'], 2),
          const Text('自己紹介'),
          _textField(5, userData?['introduction'], 3),
          const Text('好きな種目'),
          _textField(1, userData?['favoriteMenu'], 4),
          const Text('トレーニング回数'),
          _trainingTimesField(ref),
          const Text('大会実績'),
          _textField(1, userData?['tournamentResults'], 5),
        ],
      ),
    );

    // プロフィール画面
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF7b755e),
            title: const Center(child: Text('プロフィール編集')),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(10.0, 10.0),
                  backgroundColor: const Color(0xFF7b755e),
                ),
                onPressed: () {
                  final notifier = ref.read(userNotifierProvider.notifier);
                  notifier.updateState('1', userData);
                },
                child: const Text('保存'),
              )
            ],
          ),
          body: SingleChildScrollView(
            child:
                Padding(padding: const EdgeInsets.all(16.0), child: userInfo),
          ),
        ),
      ),
    );
  }

  // 名前/職業/自己紹介/好きな種目/大会実績
  Widget _textField(int lines, initValue, divNo) {
    return Card(
      child: TextField(
        controller: TextEditingController(text: initValue),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        maxLines: lines,
        onChanged: (value) {
          switch (divNo) {
            case 1:
              userData?['userName'] = value;
              break;
            case 2:
              userData?['job'] = value;
              break;
            case 3:
              userData?['introduction'] = value;
              break;
            case 4:
              userData?['favoriteMenu'] = value;
              break;
            case 5:
              userData?['tournamentResults'] = value;
              break;
          }
        },
      ),
    );
  }

  // 性別
  Widget _selectField(ref, context) {
    final list = [];
    genderDiv.forEach((k, v) => list.add(Gender(k, v)));
    return SizedBox(
      width: 500,
      child: Card(
        color: const Color(0xFF565656),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButton(
            underline: Container(),
            isExpanded: true,
            items: [
              for (var a in list)
                DropdownMenuItem(
                  value: a.key,
                  child: Text(a.gender),
                )
            ],
            value: userData?['gender'],
            onChanged: (value) {
              userData?['gender'] = value;
              final notifier = ref.read(userNotifierProvider.notifier);
              notifier.rewriting();
            },
          ),
        ),
      ),
    );
  }

  // 生年月日
  Widget _birthDayField(context, data, ref) {
    var bdData = data['birthday'].toDate();
    var initBD = DateFormat('yyyy/MM/dd')
        .format(bdData)
        .toString();
    return Card(
      child: TextFormField(
        controller: TextEditingController(text: initBD),
        focusNode: AlwaysDisabledFocusNode(),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              onConfirm: (date) {
                userData?['birthday'] = date.toString();
                initBD = userData?['birthday'];
                final notifier = ref.read(userNotifierProvider.notifier);
                notifier.rewriting();
              },
              minTime: DateTime(1960, 1, 1),
              maxTime: DateTime(2025, 12, 31),
              currentTime: DateTime(bdData.year, bdData.month, bdData.day), locale: LocaleType.jp);
        },
      ),
    );
  }

  // トレーニング回数
  Widget _trainingTimesField(ref) {
    // トレーニング回数
    final trainingTimesList = [];
    trainingTimesDiv
        .forEach((k, v) => trainingTimesList.add(TrainingTimes(k, v)));

    // 週/月
    final weekOrMonthList = [];
    weekOrMonthDiv.forEach((k, v) => weekOrMonthList.add(WeekOrMonth(k, v)));

    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Card(
            color: const Color(0xFF565656),
            child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              items: [
                for (var a in trainingTimesList)
                  DropdownMenuItem(
                    value: a.key,
                    child: Container(
                      alignment: Alignment.center,
                        child: Text(a.times)),
                  )
              ],
              value: userData?['trainingTimes'],
              onChanged: (value) {
                userData?['trainingTimes'] = value;
                final notifier = ref.read(userNotifierProvider.notifier);
                notifier.rewriting();
              },
            ),
          ),
        ),
        const Text('回　/　'),
        SizedBox(
          width: 100,
          child: Card(
            color: const Color(0xFF565656),
            child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              items: [
                for (var a in weekOrMonthList)
                  DropdownMenuItem(
                    value: a.key,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(a.weekOrMonth)),
                  )
              ],
              value: userData?['weekOrMonth'],
              onChanged: (value) {
                userData?['weekOrMonth'] = value;
                final notifier = ref.read(userNotifierProvider.notifier);
                notifier.rewriting();
              },
            ),
          ),
        )
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
