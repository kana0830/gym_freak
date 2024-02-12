import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/models/training_memo.dart';

import '../models/user.dart';

class TrainingMemoRepository {

  @override
  // トレーニング記録取得
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTrainingMemo(String userIdKey) async {

    List<QueryDocumentSnapshot<Map<String, dynamic>>> trainings = [];

    await FirebaseFirestore.instance.collection('trainingMemo')
        .doc(userIdKey)
        .collection('menus')
        .get()
        .then((querySnapshot) => {
      trainings.addAll(querySnapshot.docs)
    });

    return trainings;
  }

  // トレーニング部位取得
  Future<Map<String, dynamic>> getTrainingPart(String userIdKey) async {

    Map<String, dynamic> trainingPart = {};
    await FirebaseFirestore.instance.collection('trainingMemo')
        .doc(userIdKey).get().then(
            (DocumentSnapshot doc) {
              trainingPart = doc.data() as Map<String, dynamic>;
        });

    return trainingPart;
  }

  void insertTrainingMemo(userIdKey, partValue) async{
    await FirebaseFirestore.instance.collection('trainingMemo').doc(userIdKey).set({
      'part' : partValue,
    });
    getTrainingMemo(userIdKey);
  }

  void updateTrainingMemo(userIdKey, partValue) async{
    await FirebaseFirestore.instance.collection('trainingMemo').doc('120240211').set({
      'part' : partValue,
    });
  }

  void updateTrainingPart(id, trainingMemo) async{
    await FirebaseFirestore.instance.collection('trainingMemo').doc().set({
      'part' : trainingMemo['part'],
      // 'record' : trainingMemo['record'],
    });
  }
}