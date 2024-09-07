// domain/usecases/get_user_data.dart

import '../../entities/history_entity.dart';
import '../../repositories/history_repository.dart';

class UpdateScoreData {
  final HistoryRepository repository;

  UpdateScoreData(this.repository);

  Future<List<HistoryEntity>> call() async {
    return await repository.getHistoryData();
  }
}
