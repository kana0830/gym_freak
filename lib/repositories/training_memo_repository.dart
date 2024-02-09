import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class TrainingMemoRepository {

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getTrainingMemo(String userIdKey) async {

    List<QueryDocumentSnapshot<Map<String, dynamic>>> trainings = [];

    await FirebaseFirestore.instance.collection('TrainingMemo')
        .where("userIdKey", isEqualTo: userIdKey)
        .get()
        .then((querySnapshot) => {
      trainings = querySnapshot.docs
    });
    return trainings.first;
  }

  void updateTrainingMemo(id, trainingMemo) async{
    await FirebaseFirestore.instance.collection('TrainingMemo').doc().set({
      'spot' : trainingMemo['spot'],
      'startTime' : trainingMemo['startTime'],
      'endTime' : trainingMemo['endTime'],
      'part' : trainingMemo['part'],
      'record' : trainingMemo['record'],
    });
  }
}