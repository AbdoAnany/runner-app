// domain/usecases/get_history_data.dart

import '../../../data/entities/history_entity.dart';
import '../../repositories/history_repository.dart';

class GetHistoryData {
  final HistoryRepository repository;

  GetHistoryData(this.repository);

  Future<List<HistoryEntity>> call() async {
    return await repository.getHistoryData();
  }
}
