import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/division.dart';
import '../../../view_models/user_notifier.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class EditProfile extends ConsumerWidget {
  EditProfile(this.userData, {
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
          _textField(1, ref, userData?['userName']),
          const Text('性別'),
          _selectField(),
          const Text('生年月日'),
          _birthDayField(context, data),
          const Text('職業'),
          _textField(1, ref, userData?['job']),
          const Text('自己紹介'),
          _textField(5, ref, userData?['introduction']),
          const Text('好きな種目'),
          _textField(1, ref, userData?['favoriteMenu']),
          const Text('トレーニング回数'),
          _trainingTimesField(),
          const Text('大会実績'),
          _textField(1, ref, userData?['tournamentResults']),
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

  Widget _textField(int lines, ref, initValue) {
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
          final notifier = ref.read(userNotifierProvider.notifier);
          notifier.updateState('1', userData?['introduction']);
        },
      ),
    );
  }

  Widget _birthDayField(context, data) {
    return Card(
      child: TextFormField(
        initialValue: (DateFormat('yyyy/MM/dd').format(data['birthday'].toDate()).toString()),
        focusNode: AlwaysDisabledFocusNode(),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1960, 1, 1),
              maxTime: DateTime(2025, 12, 31), onChanged: (date) {
            print(date);
          }, onConfirm: (date) {
            print(date);
          }, currentTime: DateTime(2000, 1, 1), locale: LocaleType.jp);
        },
      ),
    );
  }

  Widget _trainingTimesField() {
    int selectTimes = 1;
    int weekOrMonth = 1;
    return Card(
      color: const Color(0xFF565656),
      child: Row(
        children: [
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text('1'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('2'),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text('3'),
              ),
              DropdownMenuItem(
                value: 4,
                child: Text('4'),
              ),
              DropdownMenuItem(
                value: 5,
                child: Text('5'),
              ),
            ],
            value: selectTimes,
            onChanged: (int? value) {
              selectTimes = value!;
            },
          ),
          const Text('回 / '),
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text('週'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('月'),
              ),
            ],
            value: weekOrMonth,
            onChanged: (int? value) {
              weekOrMonth = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _selectField() {
    int gender = 1;
    return Card(
      color: const Color(0xFF565656),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 30.0),
            child: Text('性別'),
          ),
          DropdownButton(
            items: genderDiv.forEach ((int key, String value){
              DropdownMenuItem(
              value: key,
              child: Text(value),
                );
            }),
            value: gender,
            onChanged: (int? value) {
              gender = value!;
            },
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
