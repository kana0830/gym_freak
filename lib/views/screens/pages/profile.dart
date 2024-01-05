import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_models/user_notifier.dart';
import '../../style/style.dart';

class Profile extends ConsumerWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);
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
                      child: Image.asset('assets/images/profile.jpeg'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('33歳'),
                      const Text('  /  '),
                      Text(data['gender']),
                      const Text('  /  '),
                      Text(data['job']),
                    ],
                  ),
                ),
                Column(
                  children: [
                    _listContent('自己紹介', data['introduction']),
                    _listContent('好きな種目', data['favoriteMenu']),
                    _listContent('トレーニング回数', data['trainingTimes']),
                    _listContent('大会実績', data['tournamentResults'])
                  ],
                ),
              ],)
    );

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

  Widget _listContent(String textTitle, String textContent) {
    return Card(
      child: ListTile(
        title: _textTitle(textTitle),
        subtitle: Text(textContent),
      ),
    );
  }
}
