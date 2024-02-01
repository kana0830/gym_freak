import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/view_models/training_memo_notifier.dart';
import 'package:gym_freak/views/components/list_content.dart';
import 'package:gym_freak/views/screens/pages/edit_training_memo.dart';
import 'package:intl/intl.dart';
import '../../../common/common_data_util.dart';

// トレーニング記録画面
class TrainingMemo extends ConsumerWidget {
  const TrainingMemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingMemo = ref.watch(trainingMemoNotifierProvider);
    Map<String, dynamic>? trainingMemoData = {
      'menu': 'カール',
      'data': [
        {
          'set': '1',
          'weight': '10',
          'times': '12',
        },
        {
          'set': '2',
          'weight': '10',
          'times': '10',
        },
        {
          'set': '3',
          'weight': '10',
          'times': '10',
        },
      ],
    };

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    // ユーザー情報表示部分
    final trainingMemoInfo = trainingMemo.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) {
          if (data == null || data.data() == null) {
            return Text('今日のトレーニング記録はまだありません');
          } else {
            trainingMemoData = data.data();
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.room),
                      Text(data?['spot']),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      Text(DateFormat('MM/dd kk:mm')
                          .format(data!['startTime'].toDate())
                          .toString()),
                      Text('　〜　'),
                      Text(DateFormat('MM/dd kk:mm')
                          .format(data!['endTime'].toDate())
                          .toString()),
                      // Text(data['startTime'].difference(data['startTime']).toString()),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.accessibility),
                      Text(data?['part']),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  // listContent.listFrame(menuData!),
                  // listContent.listFrame('ベンチプレス', '8kg', '12'),
                  // listContent.listFrame('サイドベント', '8kg', '12'),
                ],
              ),
            );
          }
        },);

    // プロフィール画面
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7b755e),
          title: Text(today),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(10.0, 10.0),
                backgroundColor: const Color(0xFF7b755e),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditTrainingMemo()));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
        body: trainingMemoInfo,
      ),
    );
  }
}
