import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/training_memo_notifier/calender_notifier.dart';
import '../../../../view_models/training_memo_notifier/calender_part_notifier.dart';

/// 戻るボタン
class BackButtonWidget extends ConsumerWidget {
  DateTime selectedDay;
  AsyncValue<List<QueryDocumentSnapshot<Map<String, dynamic>>>> menus;
  AsyncValue<Map<String, dynamic>> trainingPart;

  BackButtonWidget(
      {super.key,
      required this.selectedDay,
      required this.menus,
      required this.trainingPart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(color: Color(0xFF7b755e)),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF7b755e))),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        onPressed: () {
          final notifier = ref.read(calenderNotifierProvider.notifier);
          notifier.setState(selectedDay);
          final partNotifier = ref.read(calenderPartNotifierProvider.notifier);
          Navigator.pop(context);
        },
      ),
    );
  }
}
