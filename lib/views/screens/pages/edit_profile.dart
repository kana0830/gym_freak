import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_models/user_notifier.dart';
import '../../components/custom_radio_button.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({
    super.key,
  });

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
          _textFiled('名前', 1),
          const CustomRadioButton(),
          _birthDayField(context, data),
          _textFiled('職業', 1),
          _textFiled('自己紹介', 5),
          _textFiled('好きな種目', 1),
          _trainingTimesField(),
          _textFiled('大会実績', 1),
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
                  // TODO DB保存処理
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

  Widget _textFiled(String labelText, int lines) {
    return Card(
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        maxLines: lines,
      ),
    );
  }

  Widget _birthDayField(context, data) {
    return Card(
      child: TextFormField(
        initialValue: data['birthday'].toString(),
        focusNode: AlwaysDisabledFocusNode(),
        decoration: const InputDecoration(
          labelText: '生年月日',
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
      color: Color(0xFF565656),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('トレーニング回数'),
          ),
          DropdownButton(items: const [
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
          DropdownButton(items: const [
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
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
