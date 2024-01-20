import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class TrainingMemoRepository {

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getTrainingMemo() async {
    // final querySnapshot = await FirebaseFirestore.instance.collection('user').where('1').get();
    final db = FirebaseFirestore.instance;
    final user = db
        .collection('trainingMemo')
        .doc('1')
        .get();

    return user;
  }

  void updateUser(id, user) async{
    await FirebaseFirestore.instance.collection('user').doc(id).update({
      'birthday' : DateTime.parse(user['birthday']),
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