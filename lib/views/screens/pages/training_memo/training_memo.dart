import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/views/components/list_content.dart';
import 'package:gym_freak/views/screens/pages/training_memo/edit_training_memo.dart';
import 'package:intl/intl.dart';
import '../../../../common/common_data_util.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';

// トレーニング記録画面
class TrainingMemo extends ConsumerWidget {
  const TrainingMemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingMemo = ref.watch(trainingMemoNotifierProvider);

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    // ユーザー情報表示部分
    final trainingMemoInfo = trainingMemo.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) {
          if (data == null || data.data() == null) {
            return const Text('今日のトレーニング記録はまだありません');
          } else {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.room),
                      Text(data?['spot']),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      Text(DateFormat('MM/dd kk:mm')
                          .format(data!['startTime'].toDate())
                          .toString()),
                      const Text('　〜　'),
                      Text(DateFormat('MM/dd kk:mm')
                          .format(data!['endTime'].toDate())
                          .toString()),
                      // Text(data['startTime'].difference(data['startTime']).toString()),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.accessibility),
                      Text(data?['part']),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  _listContent(data?['record']),
                ],
              ),
            );
          }
        },);

    // プロフィール画面
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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


  // 文章系表示部分のwidget表示
  Widget _listContent(Map<String, dynamic> record) {
    var weigh = '';
    if (record['weight'] != null) {
      weigh = record['weight'];
    }
    return Card(
      child: ListTile(
        title: _textTitle(record['menu']),
        subtitle: Row(
          children: [
            Text(weigh),
            Text('×'),
            Text('${record['reps']}'),
            Text('×'),
            Text('${record['sets']}'),
          ],
        ),
      ),
    );
  }

  // 横並び部分タイトルスタイル
  Widget _textTitle(String textTitle) {
    return Text(
      textTitle,
      style: const TextStyle(
          fontSize: 16.0,
          color: Color(0xFFFFF59D),
          fontWeight: FontWeight.bold),
    );
  }
}
