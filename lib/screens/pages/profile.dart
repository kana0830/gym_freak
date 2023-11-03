import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../style.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                    child: Image.asset("assets/images/profile.jpeg"),
                  ),
                ],
              ),
              // TODO
              _profileDetail(),
              Card(child: _myProfile()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textTitle(String textTitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        textTitle,
        style: const TextStyle(
            fontSize: 16.0,
            color: Color(0xFFFFF59D),
            fontFamily: BoldFont,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _profileDetail() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("花南"),
          Text("  /  "),
          Text("33歳"),
          Text("  /  "),
          Text("女"),
        ],
      ),
    );
  }

  Widget _introduction() {
    return const Text("筋トレを始めて半年です。");
  }

  Widget _favoriteMenu() {
    return const Text("DL / サイドレイズ / カール");
  }

  Widget _trainingTimes() {
    return const Text("6日/週");
  }

  Widget _tournamentResults() {
    return const Text("NABBA KOREA 2023");
  }

  _myProfile() {
    return Column(
      children: [
        _textTitle("自己紹介"),
        // TODO
        _introduction(),
        _textTitle("好きな種目"),
        // TODO
        _favoriteMenu(),
        _textTitle("トレーニング回数"),
        // TODO
        _trainingTimes(),
        _textTitle("大会実績"),
        // TODO
        _tournamentResults(),
      ],
    );
  }
}
