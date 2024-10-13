// domain/usecases/get_user_data.dart

import '../../../data/models/user_data_model.dart';
import '../../repositories/user_data_repository.dart';

class GetUserData {
  final UserDataRepository repository;

  GetUserData(this.repository);

  Future<UserDataDataModel> call() async {
    return await repository.getUserDataData();
  }
}
