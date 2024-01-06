import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_models/user_notifier.dart';
import '../../style/style.dart';
import 'package:age_calculator/age_calculator.dart';

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
          _textFiled('名前'),
          _textFiled('職業'),
          _textFiled('自己紹介'),
          _listContent('自己紹介', data['introduction']),
          _listContent('好きな種目', data['favoriteMenu']),
          _listContent('トレーニング回数', '${data['trainingTimes']}回'),
          _listContent('大会実績', data['tournamentResults']),
        ],
      ),
    );

    // プロフィール画面
    return SafeArea(
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
          child: Padding(padding: const EdgeInsets.all(16.0), child: userInfo),
        ),
      ),
    );
  }

  // 文章系表示部分のwidget表示
  Widget _listContent(String textTitle, String textContent) {
    return Card(
      child: ListTile(
        title: _textTitle(textTitle),
        subtitle: Text(textContent),
      ),
    );
  }

  // 横並び部分タイトルスタイル
  Widget _textTitle(String textTitle) {
    return Text(
      textTitle,
      style: const TextStyle(
          fontSize: 16.0,
          color: Color(0xFFFFF59D),
          fontFamily: BoldFont,
          fontWeight: FontWeight.bold),
    );
  }

  // 年齢計算
  String _getAge(Timestamp birthday) {
    var bDayToDate = birthday.toDate();
    DateTime bDay = DateTime(bDayToDate.year, bDayToDate.month, bDayToDate.day);
    var duration = AgeCalculator.age(bDay);
    return duration.years.toString();
  }

  Widget _textFiled(String labelText) {
    return Card(
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
