import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/common_data_util.dart';
import '../../models/aurh_service.dart';
import '../../repositories/training_memo_repository.dart';

part 'calender_select_day_notifier.g.dart';

@riverpod
class CalenderSelectDayNotifier extends _$CalenderSelectDayNotifier {

  @override
  Widget build() {
    return Container();
  }

  /// 書き換え
  void setState(DateTime day, textColor) {
    state = AnimatedContainer(
      color: Colors.white,
      duration: const Duration(milliseconds: 250),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFffe071),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              day!.day.toString(),
              style: TextStyle(
                color: textColor
                ,
              ),
            ),
          ),
        ),
      ),
    );
  }
}