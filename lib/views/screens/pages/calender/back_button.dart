import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/training_memo_notifier/calender_notifier.dart';
import '../../../../view_models/training_memo_notifier/calender_part_notifier.dart';

class BackButton extends ConsumerWidget {

  DateTime selectedDay;

  BackButton({super.key, required this.selectedDay});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(calenderNotifierProvider);
    final trainingPart = ref.watch(calenderPartNotifierProvider);

    return ElevatedButton(
      child: const Text(
        '←',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
      onPressed: () {
        final notifier = ref.read(calenderNotifierProvider.notifier);
        notifier.setState(selectedDay);
        final partNotifier =
        ref.read(calenderPartNotifierProvider.notifier);
      },
    );
  }
}