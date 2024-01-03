import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {

  @override
  Future<String> getUser() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('user').doc('1').get();
    final user = querySnapshot.toString();
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

  // void insertTodo(task, detail) async{
  //   await FirebaseFirestore.instance.collection('user').add({
  //     'task' : task,
  //     'detail': detail,
  //     'endFlg' : 0,
  //   });
  // }
}