import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';
import 'package:intl/intl.dart';

class TrainingMemo {

  late String id;
  late String spot;
  late Timestamp startTime;
  late Timestamp endTime;
  late String part;
  late Map<String, dynamic> record;

  TrainingMemo(Map<String, dynamic> doc, docId) {
    id = docId;
    spot = doc['spot'];
    startTime = doc['startTime'] as Timestamp;
    endTime = doc['endTime'] as Timestamp;
    part = doc['part'];
    record = {
      "menu": 'プッシュアップ',
      "weight": 20,
      "reps": 10,
      "sets": 3,
    };
  }


  void insertTrainingMemo(value) async{
    await FirebaseFirestore.instance.collection('TrainingMemo').doc().set({
      'spot' : value['spot'],
      'startTime' : value['startTime'],
      'endTime' : value['endTime'],
      'part' : value['part'],
      'record' : value['record'],
    });
  }

  void updateTrainingMemo(id, value) async{
    await FirebaseFirestore.instance.collection('TrainingMemo').doc().set({
      'spot' : value['spot'],
      'startTime' : value['startTime'],
      'endTime' : value['endTime'],
      'part' : value['part'],
      'record' : value['record'],
    });
  }
}