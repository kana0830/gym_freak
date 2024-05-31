import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingMemoRepository {
  @override

  /// トレーニング記録取得
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTrainingMemo(
      String userIdKey) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> trainings = [];

    await FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userIdKey)
        .collection('menus')
        .orderBy('createdAt')
        .get()
        .then((querySnapshot) => {trainings.addAll(querySnapshot.docs)});

    return trainings;
  }

  /// トレーニング記録登録
  void insertTrainingMemo(userIdKey, partValue) async {
    await FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userIdKey)
        .set({
      'part': partValue,
    });
    getTrainingMemo(userIdKey);
  }

  /// トレーニング記録更新
  void updateTrainingMemo(userIdKey, menuId, menus, createdAt) async {
    if (createdAt == null) {
      await FirebaseFirestore.instance
          .collection('trainingMemo')
          .doc(userIdKey)
          .collection('menus')
          .doc(menuId)
          .set({'memo': menus, 'createdAt' : DateTime.now()});
    } else {
      await FirebaseFirestore.instance
          .collection('trainingMemo')
          .doc(userIdKey)
          .collection('menus')
          .doc(menuId)
          .set({'memo': menus, 'createdAt' : createdAt});
    }

  }

  /// トレーニング記録削除
  void deleteTrainingMemo(userIdKey, menuId) async {
    await FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userIdKey)
        .collection('menus')
        .doc(menuId)
        .delete();

    FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userIdKey)
        .collection('menus')
        .doc(menuId)
        .update(
      {
        "memo": FieldValue.arrayRemove([
          {
            'reps': '',
            'sets': '',
            'weight': '',
          }
        ])
      },
    );
  }

  /// トレーニング部位取得
  Future<Map<String, dynamic>> getTrainingPart(String userIdKey) async {
    Map<String, dynamic> trainingPart = {};
    await FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userIdKey)
        .get()
        .then(
      (DocumentSnapshot doc) {
        if (doc.data() != null) {
          trainingPart = doc.data() as Map<String, dynamic>;
        }
      },
    );
    return trainingPart;
  }

  /// トレーニング部位更新
  void updateTrainingPart(userIdKey, partValue) async {
    await FirebaseFirestore.instance
        .collection('trainingMemo')
        .doc(userIdKey)
        .set({'part': partValue});
  }
}
