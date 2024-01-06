import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_models/user_notifier.dart';
import '../../style/style.dart';
import 'package:age_calculator/age_calculator.dart';

class Profile extends ConsumerWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    // ユーザー情報表示部分
    final userInfo = user.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 160,
                      // 画像表示
                      child: Image.asset('assets/images/profile.jpeg'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  // 基本情報横並び表示部分
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_getAge(data['birthday'])}歳'),
                      const Text('  /  '),
                      Text(data['gender']),
                      const Text('  /  '),
                      Text(data['job']),
                    ],
                  ),
                ),
                Column(
                  // 文章系表示部分
                  children: [
                    _listContent('自己紹介', data['introduction']),
                    _listContent('好きな種目', data['favoriteMenu']),
                    _listContent('トレーニング回数', '${data['trainingTimes']}回'),
                    _listContent('大会実績', data['tournamentResults'])
                  ],
                ),
              ],)
    );

    // プロフィール画面
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: userInfo
          ),
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
}
