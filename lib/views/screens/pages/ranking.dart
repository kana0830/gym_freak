import 'package:flutter/material.dart';

// ランキング画面
class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // TODO
          child: Center(child: Text("ranking"),),
        ),
      ),
    );
  }
}
