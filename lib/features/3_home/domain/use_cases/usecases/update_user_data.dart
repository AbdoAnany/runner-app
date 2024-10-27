// domain/usecases/get_user_data.dart

import 'package:runner_app/core/errors/failure.dart';

import '../../../../../core/usecase/use_case.dart';
import '../../../../2_auth/domain/repositories/auth_repository.dart';
import '../../../data/models/user_data_model.dart';
import '../../repositories/user_data_repository.dart';

// class UpdateScoreData {
//   final UserDataRepository repository;
//
//   UpdateScoreData(this.repository);
//
//   Future<UserDataDataModel> call() async {
//     return await repository.updateUserDataEntry(updates: updates, userId: userId);
//   }
// }
class UpdateScoreData implements UseCase1<bool?, UserDataDataModel> {
  final UserDataRepository repository;

  UpdateScoreData(this.repository);

  @override
  Future<Result<bool>> call(UserDataDataModel params) async {
    return await repository.updateUserDataEntry(updates: params.toMap(), userId: params.userId);
  }
}