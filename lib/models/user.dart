import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/common/division.dart';

class User {

  late String id;
  late String birthday;
  late String displayName;
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
    birthday = doc['birthday'];
    displayName = doc['displayName'];
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
    await FirebaseFirestore.instance.collection('user').doc('1').update({
      'birthday' : value['birthday'],
      'displayName' : value['displayName'],
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