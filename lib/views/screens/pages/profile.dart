import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../style/style.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      child: Image.asset('assets/images/profile.jpeg'),
                    ),
                  ],
                ),
                _profileDetail(),
                _myProfile(),
              ],
            ),
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

  Widget _profileDetail() {

    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('33歳'),
          Text('  /  '),
          Text('女'),
          Text('  /  '),
          Text('会社員'),
        ],
      ),
    );
  }

  Widget _myProfile() {
    return Column(
      children: [
        _listContent('自己紹介', '筋トレを始めて半年です。'),
        _listContent('好きな種目', 'DL / サイドレイズ / カール'),
        _listContent('トレーニング回数', '6日/週'),
        _listContent('大会実績', 'NABBA KOREA 2023',)
      ],
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
