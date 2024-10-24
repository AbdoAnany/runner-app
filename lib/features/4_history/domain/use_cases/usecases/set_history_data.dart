
import '../../entities/history_entity.dart';
import '../../repositories/history_repository.dart';

class SetHistoryData {
  final HistoryRepository repository;

  SetHistoryData(this.repository);

  Future<void> call(List<PointHistoryEntity> historyData) async {

    await repository.setHistoryData(historyData);
  }

  Future<bool> addHistoryEntry(PointHistoryEntity historyData) async {

  final result =  await repository.addHistoryEntry(historyData);
  return result;
  }

  Future<bool> deleteHistoryEntry(PointHistoryEntity historyData) async {

  final result =  await repository.deleteHistoryEntry(historyData.id);
  return result;
  }
}
