import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';
import 'package:intl/intl.dart';

import '../common/common_data_util.dart';

class TrainingMemo {

  late String id;
  late String userIdKey;
  late String part;
  // late Map<String, dynamic> record;

  TrainingMemo(Map<String, dynamic> doc, docId) {
    id = docId;
    userIdKey = doc['userIdKey'] + CommonDataUtil.getDateNoSlash();
    part = doc['part'];
    // record = {
    //   "menu": doc['record']['menu'],
    //   "weight": doc['record']['weight'],
    //   "reps": doc['record']['reps'],
    //   "sets": doc['record']['sets'],
    // };
  }


  void insertTrainingMemo(value) async{
    await FirebaseFirestore.instance.collection('trainingMemo').doc().set({
      'part' : value['part'],
      'record' : value['record'],
    });
  }

  void updateTrainingMemo(id, value) async{
    await FirebaseFirestore.instance.collection('trainingMemo').doc().set({
      'part' : value['part'],
      'record' : value['record'],
    },);
  }
}