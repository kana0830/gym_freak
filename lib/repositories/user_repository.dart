import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {

  @override

  /// ユーザ情報取得
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getUser(String email) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
    await FirebaseFirestore.instance.collection('user')
        .where("email", isEqualTo: email)
        .get()
        .then((querySnapshot) => {
      users = querySnapshot.docs
    });
    return users.first;
  }

  /// ユーザ情報更新
  void updateUser(Map<String, dynamic> user) async{
    await FirebaseFirestore.instance.collection('user').doc('1').update({
      'birthday' : user['birthday'] as Timestamp,
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