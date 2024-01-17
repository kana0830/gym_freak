import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';
import 'package:intl/intl.dart';

class TrainingMemoDetail {

  late String id;
  late String trainingMemoHeadId;
  late String menu;
  late String weight;
  late String reps;
  late String sets;

  TrainingMemoDetail(Map<String, dynamic> doc, docId) {
    id = docId;
    trainingMemoHeadId = doc['trainingMemoHeadId'];
    menu = doc['menu'];
    weight = doc['weight'];
    reps = doc['reps'];
    sets = doc['sets'];
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