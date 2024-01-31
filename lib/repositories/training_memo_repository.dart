import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class TrainingMemoRepository {

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getTrainingMemo() async {
    // final querySnapshot = await FirebaseFirestore.instance.collection('user').where('1').get();
    final db = FirebaseFirestore.instance;
    final user = db
        .collection('trainingMemo')
        .doc()
        .get();

    return user;
  }

  void updateTrainingMemo(id, trainingMemo) async{
    await FirebaseFirestore.instance.collection('TrainingMemo').doc().set({
      'spot' : trainingMemo['spot'],
      'startTime' : trainingMemo['startTime'],
      'endTime' : trainingMemo['endTime'],
      'part' : trainingMemo['part'],
      'menu' : trainingMemo['menu'],
    });
  }
}