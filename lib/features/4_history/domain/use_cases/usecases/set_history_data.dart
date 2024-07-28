
import '../../entities/history_entity.dart';
import '../../repositories/history_repository.dart';

class SetHistoryData {
  final HistoryRepository repository;

  SetHistoryData(this.repository);

  Future<void> call(List<HistoryEntity> historyData) async {

    await repository.setHistoryData(historyData);
  }
}
