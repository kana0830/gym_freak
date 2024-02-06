import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getUser(email) async {

    List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
    await FirebaseFirestore.instance.collection('user')
        .where("email", isEqualTo: email)
        .get()
        .then((querySnapshot) => {
      users = querySnapshot.docs
    });
    return users.first;
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