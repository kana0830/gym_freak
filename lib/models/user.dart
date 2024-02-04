import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';
import 'package:intl/intl.dart';

class User {

  late String id;
  late Timestamp birthday;
  late String email;
  late String favoriteMenu;
  late String gender;
  late String introduction;
  late String job;
  late String profileUrl;
  late String tournamentResults;
  late String trainingTimes;
  late String userName;
  late String weekOrMonth;

  User(Map<String, dynamic> doc, docId) {
    id = docId;
    birthday = doc['birthday'] as Timestamp;
    email = doc['email'];
    favoriteMenu = doc['favoriteMenu'];
    gender = doc['gender'];
    introduction = doc['introduction'];
    job = doc['job'];
    profileUrl = doc['profileUrl'];
    tournamentResults = doc['tournamentResults'];
    trainingTimes = doc['trainingTimes'];
    userName = doc['userName'];
    weekOrMonth = doc['weekOrMonth'];
  }


  void updateTodo(id, value) async{
    await FirebaseFirestore.instance.collection('user').doc(id).update({
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