import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';
import 'package:intl/intl.dart';

class TrainingMemoHead {

  late String id;
  late String spot;
  late Timestamp startTime;
  late Timestamp endTime;
  late String part;

  TrainingMemoHead(Map<String, dynamic> doc, docId) {
    id = docId;
    spot = doc['spot'];
    startTime = doc['startTime'] as Timestamp;
    endTime = doc['endTime'] as Timestamp;
    part = doc['part'];
  }


  void updateTodo(id, value) async{
    await FirebaseFirestore.instance.collection('user').doc('1').update({
      'birthday' : value['birthday'],
      'email' : value['email'],
      'favoriteMenu' : value['favoriteMenu'],
      'gender' : value['gender'],
      'introduction' : value['introduction'],
      'job' : value['job'],
      'profileUrl' : value['profileUrl'],
      'tournamentResults' : value['tournamentResults'],
      'trainingTimes' : value['trainingTimes'],
      'userName' : value['userName'],
      'weekOrMonth' : value['weekOrMonth'],
    });
  }
}