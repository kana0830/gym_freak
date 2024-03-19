import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_memo.dart';
import 'package:gym_freak/views/screens/pages/calender/my_calender.dart';

import '../../models/aurh_service.dart';
import '../../repositories/user_repository.dart';

class HomeScreen extends StatefulWidget {
  // final QueryDocumentSnapshot<Map<String, dynamic>> user;
  // const HomeScreen({super.key, required this.user});
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late List<QueryDocumentSnapshot<Map<String, dynamic>>> user;
  final currentUser = FirebaseAuth.instance.currentUser;
  final userRepository = UserRepository();

  @override
  int _currentIndex = 0;
  var _pages = [];

  void initState() {
    Future(
      () async {
        QueryDocumentSnapshot<Map<String, dynamic>> user =
            await userRepository.getUser(currentUser!.email!);
        AuthService.userId = user.id;
        _pages = [
          TrainingMemo(),
          const MyCalender(),
          // Ranking(),
          // Profile(user: widget.user),
        ];
        return user;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFFF176),
        unselectedItemColor: const Color(0xFF757575),
        items: const [
          /// 記録タブ
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: '記録',
          ),

          /// カレンダータブ
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'カレンダー',
          ),
          // TODO ランキング機能いずれ追加したい
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_chart),
          //   label: 'ランキング',
          // ),
          // TODO ランキング機能追加する際に公開したいプロフィール
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_box_rounded),
          //   label: 'マイページ',
          // ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    ));
  }
}
