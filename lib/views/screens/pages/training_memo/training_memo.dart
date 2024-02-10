import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    // トレーニング記録表示ウィジェット
    final Widget trainingMemoInfo;

    // 今日のトレーニング記録がある場合
    if (trainingMemo.hasValue) {
      // ユーザー情報表示部分
      trainingMemoInfo = trainingMemo.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) {
          if (data == null || data.data() == null) {
            return const Text('今日のトレーニング記録はまだありません');
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  _listContent(data?['record']),
                ],
              ),
            );
          }
        },
      );
      // 今日のトレーニング記録がない場合
    } else {
      trainingMemoInfo = const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('今日のトレーニング記録はまだありません'),
      );
    }

    // ヘッダ部位表示
    final Widget part = trainingMemo.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stacktrace) => Text('エラー $error'),
      data: (data) {
        return Row(
          children: [
            const Icon(Icons.accessibility),
            Text(data['part']),
          ],
        );
      },
    );

    final Dialog dialog = Dialog(
    );

    // プロフィール画面
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF7b755e),
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(today),
              ),
              Expanded(
                flex: 1,
                child: part,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: const Color(0xFFFFF59D),
          child: const Icon(Icons.add),
        ),
        body: trainingMemoInfo,
      ),
    );
  }

  // 文章系表示部分のwidget表示
  Widget _listContent(Map<String, dynamic> record) {

    return Card(
      child: ListTile(
        title: _textTitle(record['menu']),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    record['weight'],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(record['weight'] == '' ? '' : 'kg'),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  record['weight'] == '' ? '' : '×',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${record['reps']}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text('rep'),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  '×',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${record['sets']}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text('set'),
              ),
            ],
          ),
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
