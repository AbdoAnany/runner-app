import '../../../3_home/data/models/user_data_model.dart';
import '../../../2_auth/data/models/UserDataDataModel.dart';
import '../entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<PointHistoryEntity>> getHistoryData();
  Future<List<UserDataDataModel>> getAllUsersDataList();
  Future<void> setHistoryData(List<PointHistoryEntity> historyData);
  Future<bool> addHistoryEntry(PointHistoryEntity entry);
  Future<void> updateHistoryEntry(String date, Map<String, dynamic> updates);
  Future<bool> deleteHistoryEntry(String date);
}



