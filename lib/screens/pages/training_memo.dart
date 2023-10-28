import 'package:flutter/material.dart';

class TrainingMemo extends StatefulWidget {
  @override
  State<TrainingMemo> createState() => _TrainingMemoState();
}

class _TrainingMemoState extends State<TrainingMemo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(child: Text("training_memo"),),
        ),
      ),
    );
  }
}
