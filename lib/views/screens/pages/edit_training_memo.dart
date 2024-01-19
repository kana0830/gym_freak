import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/views/components/list_content.dart';

import '../../../common/common_data_util.dart';

// トレーニング編集画面
class EditTrainingMemo extends ConsumerWidget {
  EditTrainingMemo({
        super.key,
      });

  Map<String, dynamic>? userData = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userNotifierProvider);

    // ユーザー情報表示部分
    // final userInfo = user.when(
    //   loading: () => const CircularProgressIndicator(),
    //   error: (error, stacktrace) => Text('エラー $error'),
    //   data: (data) => Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       const Text('名前'),
    //       _textField(1, userData?['userName'], 1),
    //       const Text('性別'),
    //       _selectField(ref, context),
    //       const Text('生年月日'),
    //       _birthDayField(context, data, ref),
    //       const Text('職業'),
    //       _textField(1, userData?['job'], 2),
    //       const Text('自己紹介'),
    //       _textField(5, userData?['introduction'], 3),
    //       const Text('好きな種目'),
    //       _textField(1, userData?['favoriteMenu'], 4),
    //       const Text('トレーニング回数'),
    //       _trainingTimesField(ref),
    //       const Text('大会実績'),
    //       _textField(1, userData?['tournamentResults'], 5),
    //     ],
    //   ),
    // );

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    // プロフィール画面
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7b755e),
          title: const Text('トレーニング記録'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(10.0, 10.0),
                backgroundColor: const Color(0xFF7b755e),
              ),
              onPressed: () {},
              child: const Text('保存'),
            )
          ],
        ),
        body: Container()
      ),
    );
  }
}
