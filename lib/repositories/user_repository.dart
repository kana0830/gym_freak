import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    // final querySnapshot = await FirebaseFirestore.instance.collection('user').where('1').get();
    final db = FirebaseFirestore.instance;
    final user = db
        .collection('user')
        .doc('1')
        .get();

    // final data = querySnapshot.data() as Map<String, dynamic>;
    // final user = User(querySnapshot.data, '1');

    return user;
  }

  void updateUser(id, value) async{
    await FirebaseFirestore.instance.collection('user').doc(id).update({
      'birthday' : value,
      'displayName' : value,
      'email' : value,
      'favoriteMenu' : value,
      'gender' : value,
      'introduction' : value,
      'job' : value,
      'profileUrl' : value,
      'tournamentResults' : value,
      'trainingTimes' : value,
      'userName' : value,
    });
  }
}