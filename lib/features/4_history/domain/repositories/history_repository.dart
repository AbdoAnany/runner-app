import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistoryData();
  Future<List<UserModel>> getAllUsersDataList();
  Future<void> setHistoryData(List<HistoryEntity> historyData);
  Future<bool> addHistoryEntry(HistoryEntity entry);
  Future<void> updateHistoryEntry(String date, Map<String, dynamic> updates);
  Future<bool> deleteHistoryEntry(String date);
}



