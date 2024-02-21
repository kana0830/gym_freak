import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/common_data_util.dart';
import '../../../../models/aurh_service.dart';
import '../../../../view_models/training_memo_notifier/training_part_notifier.dart';

class TrainingPartDialog extends ConsumerWidget {
  TrainingPartDialog({required this.part, required this.edit, super.key});

  String part = '';
  int edit;

  // ユーザーIDキー
  String userIdKey = AuthService.userId + CommonDataUtil.getDateNoSlash();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final trainingPart = ref.watch(trainingPartNotifierProvider);

    String partValue = part;

    // トレーニング記録ダイアログ
    return Dialog(
      child: SizedBox(
        height: 160,
        child: Card(
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFFFF176), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('トレーニング部位'),
                    Card(
                      child: TextField(
                        controller: TextEditingController(text: part),
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          partValue = value;
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF59D),
                    ),
                    onPressed: () {
                      final notifier = ref.read(trainingPartNotifierProvider.notifier);
                      notifier.updateState(userIdKey, partValue);
                      Navigator.pop(context);
                    },
                    child: Text(
                      edit == 0 ? '登録' : '更新',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
