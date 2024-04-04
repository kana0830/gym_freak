import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../common/division.dart';
import '../../../style/style.dart';
import 'package:age_calculator/age_calculator.dart';
import 'edit_profile.dart';

/// プロフィール画面
class Profile extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> user;

  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? userData = user.data();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF7b755e),
          title: Text(user['userName']),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(10.0, 10.0),
                backgroundColor: const Color(0xFF7b755e),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(userData)));
              },
              child: const Icon(Icons.edit),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 160,

                      /// 画像表示
                      child: Image.asset('assets/images/profile.jpeg'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),

                  /// 基本情報横並び表示部分
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_getAge(user['birthday'] as Timestamp)}歳'),
                      const Text('  /  '),
                      Text(genderDiv[user['gender']]!),
                      const Text('  /  '),
                      Text(user['job']),
                    ],
                  ),
                ),
                Column(
                  /// 文章系表示部分
                  children: [
                    _listContent('自己紹介', user['introduction']),
                    _listContent('好きな種目', user['favoriteMenu']),
                    _listContent('トレーニング回数',
                        '${user['trainingTimes']}回 / ${weekOrMonthDiv[user['weekOrMonth']]}'),
                    _listContent('大会実績', user['tournamentResults'])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 文章系表示部分のwidget表示
  Widget _listContent(String textTitle, String textContent) {
    return Card(
      child: ListTile(
        title: _textTitle(textTitle),
        subtitle: Text(textContent),
      ),
    );
  }

  /// 横並び部分タイトルスタイル
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

  /// 年齢計算
  String _getAge(Timestamp birthday) {
    var bDayToDate = birthday.toDate();
    DateTime bDay = DateTime(bDayToDate.year, bDayToDate.month, bDayToDate.day);
    var duration = AgeCalculator.age(bDay);
    return duration.years.toString();
  }
}
