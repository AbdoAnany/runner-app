import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../models/history_data_model.dart';
import '../services/history_service.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryService service;

  HistoryRepositoryImpl(this.service);

  @override
  Future<List<HistoryEntity>> getHistoryData() async {
    final data = await service.getHistoryData();
    return data.map((e) => HistoryDataModel.fromMap(e)).toList();
  }

  @override
  Future<void> setHistoryData(List<HistoryEntity> historyData) async {
    final data =
    historyData.map((e) => (e as HistoryDataModel).toMap()).toList();
    await service.setHistoryData(data);
  }

  @override
  Future<void> addHistoryEntry(HistoryEntity entry) async {
    await service.addHistoryEntry((entry as HistoryDataModel).toMap());
  }

  @override
  Future<void> updateHistoryEntry(
      String date, Map<String, dynamic> updates) async {
    await service.updateHistoryEntry(date, updates);
  }

  @override
  Future<void> deleteHistoryEntry(String date) async {
    await service.deleteHistoryEntry(date);
  }
}
