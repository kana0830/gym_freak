import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';
import 'package:intl/intl.dart';

import '../common/common_data_util.dart';

class Menus {
  late String id;
  late List<Memo> memo;

  Menus(List<Memo> memo, docId) {
    id = docId;
    memo = memo;
  }

  void insertMenus(value, userId, menusId, memo) async {
    await FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userId)
        .collection('menus')
        .doc(menusId)
        .set({
      'memo': value['memo'],
    });
  }

  void updateMenus(id, value) async {
    await FirebaseFirestore.instance.collection('trainingMemo').doc().set(
      {
        'part': value['part'],
        'record': value['record'],
      },
    );
  }
}

class Memo {
  late String reps;
  late String sets;
  late String weight;

  Memo(Map<String, dynamic> doc) {
    reps = doc['reps'];
    sets = doc['sets'];
    weight = doc['weight'];
  }
}
