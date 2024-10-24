

import 'package:dartz/dartz.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../repositories/auth_repository.dart';

class SaveCachedUser implements UseCase<void, UserDataDataModel> {
  final AuthRepository repository;

  SaveCachedUser(this.repository);

  @override
  Future<Either<Failure, void>> call(UserDataDataModel user) async {
    return await repository.saveCachedUser(user);
  }
}
