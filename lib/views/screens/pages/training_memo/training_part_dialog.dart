import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/appColors.dart';
import '../../../../common/common_data_util.dart';
import '../../../../models/aurh_service.dart';
import '../../../../view_models/training_memo_notifier/calender_part_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_part_notifier.dart';

class TrainingPartDialog extends ConsumerWidget {
  TrainingPartDialog({required this.part, required this.edit, required this.tapDay, super.key});

  /// 部位
  String part = '';
  /// 編集モード
  int edit;
  /// 選択中日付
  DateTime tapDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// ユーザーIDキー
    String userIdKey = AuthService.userId + CommonDataUtil.changeDateNoSlash(tapDay);

    String partValue = part;

    /// トレーニング記録ダイアログ
    return Dialog(
      child: SizedBox(
        height: 160,
        child: Card(
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.yellow, width: 1),
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
                      backgroundColor: AppColors.yellow,
                    ),
                    onPressed: () {
                      var now = DateTime.now();
                      var nowDate = DateTime(now.year, now.month, now.day);
                      var tapDate = DateTime(tapDay.year, tapDay.month, tapDay.day);
                      if (tapDate.isAtSameMomentAs(nowDate)) {
                        final notifier = ref.read(trainingPartNotifierProvider.notifier);
                        notifier.updateState(tapDay, partValue);
                      } else {
                        final notifier = ref.read(calenderPartNotifierProvider.notifier);
                        notifier.updateState(tapDay, partValue);
                      }
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
