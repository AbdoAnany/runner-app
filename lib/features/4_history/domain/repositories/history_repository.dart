import '../../data/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistoryData();
  Future<void> setHistoryData(List<HistoryEntity> historyData);
  Future<void> addHistoryEntry(HistoryEntity entry);
  Future<void> updateHistoryEntry(String date, Map<String, dynamic> updates);
  Future<void> deleteHistoryEntry(String date);
}
