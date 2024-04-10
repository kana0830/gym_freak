import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../common/common_data_util.dart';
import '../../repositories/training_memo_repository.dart';
import '../../repositories/user_repository.dart';

part 'training_memo_notifier.g.dart';

@riverpod
class TrainingMemoNotifier extends _$TrainingMemoNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> trainingMemo;

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> build() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userRepository = UserRepository();
    QueryDocumentSnapshot<Map<String, dynamic>> user =
    await userRepository.getUser(currentUser!.email!);
    AuthService.userId = user.id;
    var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + CommonDataUtil.getDateNoSlash());
    return trainingMemo;
  }

  /// update
  void updateState(userIdKey, menuId, menus) async {
    _trainingMemoRepository.updateTrainingMemo(userIdKey, menuId, menus);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(userIdKey);
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }

  /// delete
  void deleteMenuState(userIdKey, menuId) async {
    _trainingMemoRepository.deleteTrainingMemo(userIdKey, menuId);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(userIdKey);
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }
}