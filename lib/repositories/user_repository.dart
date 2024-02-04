import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(id) async {
    final db = FirebaseFirestore.instance;
    final user = db
        .collection('user')
        .doc('1')
        .get();

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