import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../common/common_data_util.dart';
import '../../repositories/training_memo_repository.dart';

part 'calender_memo_notifier.g.dart';

@riverpod
class CalenderMemoNotifier extends _$CalenderMemoNotifier {

  final _trainingMemoRepository = TrainingMemoRepository();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> trainingMemo;

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> build() async {
    var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + CommonDataUtil.getDateNoSlash());
    return trainingMemo;
  }

  /// 書き換え
  void setState(DateTime day) async {
    var monthString = day.month.toString().length == 1 ? '0${day.month}' : day.month.toString();
    var dayString = day.day.toString().length == 1 ? '0${day.day}' : day.day.toString();
    var dateString = day.year.toString() + monthString + dayString;
    var trainingMemo = await _trainingMemoRepository.getTrainingMemo(AuthService.userId + dateString);
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }

  // update
  void updateState(userIdKey, menuId, menus) async {
    _trainingMemoRepository.updateTrainingMemo(userIdKey, menuId, menus);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(userIdKey);
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }

  // delete
  void deleteMenuState(userIdKey, menuId) async {
    _trainingMemoRepository.deleteTrainingMemo(userIdKey, menuId);
    trainingMemo = await _trainingMemoRepository.getTrainingMemo(userIdKey);
    state = AsyncData<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(trainingMemo);
  }
}