import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_memo_dialog.dart';
import 'package:gym_freak/views/screens/pages/training_memo/training_part_dialog.dart';
import '../../../../common/appColors.dart';
import '../../../../common/common_data_util.dart';
import '../../../../view_models/training_memo_notifier/calender_memo_notifier.dart';
import '../../../../view_models/training_memo_notifier/calender_part_notifier.dart';
import '../../../../view_models/training_memo_notifier/training_memo_notifier.dart';
import 'back_button_widget.dart';

/// トレーニング記録画面
class TrainingMemoPast extends ConsumerWidget {

  /// 選択中日付
  DateTime tapDay;

  /// メニュー
  AsyncValue<List<QueryDocumentSnapshot<Map<String, dynamic>>>> menus;

  /// トレーニング部位
  AsyncValue<Map<String, dynamic>> trainingPart;

  TrainingMemoPast({super.key, required this.tapDay, required this.menus, required this.trainingPart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// トレーニング部位状態管理
    final trainingPart = ref.watch(calenderPartNotifierProvider);
    /// トレーニング記録状態管理
    final trainingMemo = ref.watch(calenderMemoNotifierProvider);

    /// ユーザーIDキー
    String userIdKey = AuthService.userId + CommonDataUtil.changeDateNoSlash(tapDay);

    /// メニュー
    QueryDocumentSnapshot<Map<String, dynamic>>? menu;

    /// メニューデータをセットして書き換え
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final partNotifier = ref.read(calenderPartNotifierProvider.notifier);
      partNotifier.setState(userIdKey);
      final memoNotifier = ref.read(calenderMemoNotifierProvider.notifier);
      memoNotifier.setState(userIdKey);
    });

    /// トレーニング記録表示ウィジェット
    Widget trainingMemoInfo;

    /// トレーニング記録表示部分
    trainingMemoInfo = trainingMemo.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stacktrace) => Text('エラー $error'),
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text(
              'Enjoy Training!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0,),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                _listContent(data, context, ref, userIdKey),
              ],
            ),
          );
        }
      },
    );

    /// ヘッダ部位表示
    final Widget part = trainingPart.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stacktrace) => Text('エラー $error'),
      data: (data) {
        if (data.isEmpty) {
          return headerPart('', context, ref);
        } else {
          return headerPart(data['part'], context, ref);
        }
      },
    );

    /// トレーニング記録
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkYellow,
          iconTheme: const IconThemeData(
            color: AppColors.darkYellow,
          ),
          leading: BackButtonWidget(selectedDay: tapDay, menus: menus, trainingPart: trainingPart,),
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('${CommonDataUtil.getDate(tapDay)}${CommonDataUtil.getDayOfWeek()}'),
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
            showDialog(
              context: context,
              builder: (context) => TrainingMemoDialog(
                menus: menu,
                menuId: '',
                createdAt: null,
                edit: 0,
                data: tapDay,
              ),
            );
          },
          backgroundColor: AppColors.yellow,
          child: const Icon(Icons.add),
        ),
        body: trainingMemoInfo,
      ),
    );
  }

  /// トレーニング部位ヘッダ部
  Widget headerPart(part, context, ref) {
    if (part == '') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TrainingPartDialog(
              part: part,
              edit: 0,
              tapDay: tapDay,
            ),
          );
        },
        child: const Text(
          '鍛える部位の登録',
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => TrainingPartDialog(
              part: part,
              edit: 0,
              tapDay: tapDay,
            ),
          );
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

  /// メインwidget表示
  Widget _listContent(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> menus, context, ref, userIdKey) {
    return Expanded(
      child: ListView(
        children: [
          for (var menu in menus)
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => TrainingMemoDialog(
                    menus: menu,
                    menuId: menu.id,
                    createdAt: menu.data()['createdAt'].toDate(),
                    edit: 1,
                    data: tapDay,
                  ),
                );
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("削除してよろしいですか。"),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.yellow,
                              foregroundColor: Colors.black),
                          child: const Text("いいえ"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.yellow,
                                foregroundColor: Colors.black),
                            child: const Text("はい"),
                            onPressed: () {
                              final notifier = ref
                                  .read(trainingMemoNotifierProvider.notifier);
                              notifier.deleteMenuState(userIdKey, menu.id);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    menu.id,
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColors.yellow,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 80.0),
                    child: Column(
                      children: [
                        for (int i = 0; i < menu.data()['memo'].length; i++)
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
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
                              Expanded(
                                flex: 3,
                                child: Text(
                                    menu.data()['memo'][i]['reps'] == ''
                                        ? ''
                                        : 'rep'),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  menu.data()['memo'][i]['sets'] == ''
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
                                    '${menu.data()['memo'][i]['sets']}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                    menu.data()['memo'][i]['sets'] == ''
                                        ? ''
                                        : 'set'),
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
}
