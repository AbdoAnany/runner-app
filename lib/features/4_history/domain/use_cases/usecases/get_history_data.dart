// domain/usecases/get_user_data.dart

import '../../entities/history_entity.dart';
import '../../repositories/history_repository.dart';

class GetHistoryData {
  final HistoryRepository repository;

  GetHistoryData(this.repository);

  Future<List<PointHistoryEntity>> call() async {
    return await repository.getHistoryData();
  }
}
