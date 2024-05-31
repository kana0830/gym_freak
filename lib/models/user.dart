import 'package:cloud_firestore/cloud_firestore.dart';

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
}