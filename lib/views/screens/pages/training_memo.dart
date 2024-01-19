import 'package:flutter/material.dart';
import 'package:gym_freak/views/components/list_content.dart';
import 'package:gym_freak/views/screens/pages/edit_training_memo.dart';

import '../../../common/common_data_util.dart';

// トレーニング記録画面
class TrainingMemo extends StatefulWidget {
  const TrainingMemo({super.key});

  @override
  State<TrainingMemo> createState() => _TrainingMemoState();
}

class _TrainingMemoState extends State<TrainingMemo> {
  final listContent = ListContent();
  List<Map<String, dynamic>> menuData = [
    {
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
    },
    // {
    //   'menu': 'ベンチプレス',
    //   '1': {
    //     'weight': 10,
    //     'times': 12,
    //   },
    //   '2': {
    //     'weight': 10,
    //     'times': 10,
    //   },
    //   '3': {
    //     'weight': 10,
    //     'times': 10,
    //   },
    // },
    // {
    //   'menu': 'サイドベント',
    //   'times': {
    //     1: 12,
    //     2: 12,
    //     3: 12,
    //   },
    // },
    // {
    //   'menu': 'リバースプッシュアップ',
    //   'times': {
    //     1: 12,
    //     2: 12,
    //     3: 10,
    //   },
    // },
  ];

  @override
  Widget build(BuildContext context) {

    // 表示用日付を取得
    String today = CommonDataUtil.getDate() + CommonDataUtil.getDayOfWeek();

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
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.room),
                  Text('  Forza神田'),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(Icons.access_time),
                  Text('  20:40~21:30  0:50:00'),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(Icons.accessibility),
                  Text('  腕 / 胸'),
                ],
              ),
              SizedBox(height: 10.0),
              // listContent.listFrame(menuData!),
              // listContent.listFrame('ベンチプレス', '8kg', '12'),
              // listContent.listFrame('サイドベント', '8kg', '12'),
            ],
          ),
        ),
      ),
    );
  }
}
