import 'package:flutter/material.dart';
import 'package:gym_freak/view/components/list_content.dart';

class TrainingMemo extends StatefulWidget {
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(Icons.room),
                  Text('  Forza神田'),
                ],
              ),
              SizedBox(height: 10.0),
              const Row(
                children: [
                  Icon(Icons.access_time),
                  Text('  20:40~21:30  0:50:00'),
                ],
              ),
              SizedBox(height: 10.0),
              const Row(
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
