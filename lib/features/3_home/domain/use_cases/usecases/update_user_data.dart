// domain/usecases/get_user_data.dart

import '../../../data/models/user_data_model.dart';
import '../../entities/user_data_entity.dart';
import '../../repositories/user_data_repository.dart';

class UpdateScoreData {
  final UserDataRepository repository;

  UpdateScoreData(this.repository);

  Future<UserDataDataModel> call() async {
    return await repository.getUserDataData();
  }
}
