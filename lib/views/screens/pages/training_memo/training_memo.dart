import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/models/aurh_service.dart';
import '../../../../common/common_data_util.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_part_notifier.dart';

// トレーニング記録画面
class TrainingMemo extends ConsumerWidget {
  TrainingMemo({super.key});

  // ユーザーIDキー
  String userIdKey = AuthService.userId + CommonDataUtil.getDateNoSlash();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingPart = ref.watch(trainingPartNotifierProvider);
    final trainingMemo = ref.watch(trainingMemoNotifierProvider);

    // トレーニング記録表示ウィジェット
    Widget trainingMemoInfo;

    // トレーニング記録登録用
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? trainingMemoData;

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

    // 今日のトレーニング記録がある場合
    if (trainingMemo.hasValue) {
      // ユーザー情報表示部分
      trainingMemoInfo = trainingMemo.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stacktrace) => Text('エラー $error'),
        data: (data) {
          trainingMemoData = data;
          if (data.isEmpty) {
            return const Text('今日のトレーニング記録はまだありません');
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  _listContent(data, context, ref),
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
    final Widget part = trainingPart.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stacktrace) => Text('エラー $error'),
      data: (data) {
        return headerPart(data['part'], context, ref);
      },
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
            trainingMemoDialog(context, ref, 0, trainingMemoData);
          },
          backgroundColor: const Color(0xFFFFF59D),
          child: const Icon(Icons.add),
        ),
        body: trainingMemoInfo,
      ),
    );
  }

  // トレーニング部位ヘッダ部
  Widget headerPart(part, context, ref) {
    if (part == null) {
      return ElevatedButton(
        onPressed: () {
          trainingPartDialog(context, ref, 0, part);
        },
        child: const Text('今日鍛える部位の登録'),
      );
    } else {
      return InkWell(
        onTap: () {
          trainingPartDialog(context, ref, 1, part);
        },
        child: Row(
          children: [
            const Icon(Icons.accessibility),
            Text(part),
          ],
        ),
      );
    }
  }

  // トレーニング部位ダイアログ
  Future trainingPartDialog(BuildContext context, ref, int edit, part) async {
    String partValue = part;
    var ret = await showDialog(
      context: context,
      builder: (context) => Dialog(
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
                        final notifier =
                            ref.read(trainingPartNotifierProvider.notifier);
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
      ),
    );
  }

  // トレーニング記録ダイアログ
  Future trainingMemoDialog(BuildContext context, ref, int edit, menu) async {
    var _screenSize = MediaQuery.of(context).size;
    var ret = await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: _screenSize.height * 0.4,
            maxHeight: _screenSize.height * 0.8,
          ),
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
                      const Text('種目'),
                      _textField(1, 'ベンチプレス', 0, menu),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            '重量',
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text('回数'),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text('セット数'),
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < menu.data()['memo'].length; i++)
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: _textField(
                              2, '20', 1, menu.data()['memo'][i]['weight']),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text('kg'),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            '×',
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: _textField(
                              3, '10', 1, menu.data()['memo'][i]['reps']),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text('rep'),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            '×',
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: _textField(
                              4, '10', 1, menu.data()['memo'][i]['sets']),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text('set'),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Icon(Icons.delete),
                        )
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
                        final notifier =
                            ref.read(trainingMemoNotifierProvider.notifier);
                        notifier.updateState(userIdKey);
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
      ),
    );
  }

  // 入力欄
  Widget _textField(int lines, initValue, int alignFlg, menu) {
    return Card(
      child: TextField(
        textAlign: alignFlg == 1 ? TextAlign.end : TextAlign.start,
        controller: TextEditingController(text: initValue),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.white),
          filled: true,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          switch (lines) {
            case 1:
              menu.id = value;
              break;
            case 2:
              menu = value;
              break;
            case 3:
              menu = value;
              break;
            case 4:
              menu = value;
              break;
          }
        },
      ),
    );
  }

  // メインwidget表示
  Widget _listContent(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> menus, context, ref) {
    return Expanded(
      child: ListView(
        children: [
          for (var menu in menus)
            InkWell(
              onTap: () {
                trainingMemoDialog(context, ref, 0, menu);
              },
              child: Card(
                child: ListTile(
                  title: _textTitle(menu.id),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 80.0),
                    child: Column(
                      children: [
                        for (int i = 0; i < menu.data()['memo'].length; i++)
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    menu.data()['memo'][i]['weight'],
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
                                child: Text(
                                    menu.data()['memo'][i]['weight'] == ''
                                        ? ''
                                        : 'kg'),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  menu.data()['memo'][i]['weight'] == ''
                                      ? ''
                                      : '×',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '${menu.data()['memo'][i]['reps']}',
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
                                    '${menu.data()['memo'][i]['sets']}',
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
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
