import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUser(email) async {
    final db = FirebaseFirestore.instance;
    final userSnapShot = db
        .collection('user')
        .where('email', isEqualTo: email)
        .get();
    QuerySnapshot<Map<String, dynamic>> user;
    userSnapShot.then((value) =>  user = value!);
    return user;
  }

  void updateUser(user) async{
    await FirebaseFirestore.instance.collection('user').doc(user['id']).update({
      'birthday' : user['birthday'],
      'email' : user['email'],
      'favoriteMenu' : user['favoriteMenu'],
      'gender' : user['gender'],
      'introduction' : user['introduction'],
      'job' : user['job'],
      'profileUrl' : user['profileUrl'],
      'tournamentResults' : user['tournamentResults'],
      'trainingTimes' : user['trainingTimes'],
      'userName' : user['userName'],
      'weekOrMonth' : user['weekOrMonth'],
    });
  }
}