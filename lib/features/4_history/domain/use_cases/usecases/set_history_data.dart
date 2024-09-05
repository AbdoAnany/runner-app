
import '../../entities/history_entity.dart';
import '../../repositories/history_repository.dart';

class SetHistoryData {
  final HistoryRepository repository;

  SetHistoryData(this.repository);

  Future<void> call(List<HistoryEntity> historyData) async {

    await repository.setHistoryData(historyData);
  }

  Future<bool> addHistoryEntry(HistoryEntity historyData) async {

  final result =  await repository.addHistoryEntry(historyData);
  return result;
  }

  Future<bool> deleteHistoryEntry(HistoryEntity historyData) async {

  final result =  await repository.deleteHistoryEntry(historyData.id);
  return result;
  }
}
