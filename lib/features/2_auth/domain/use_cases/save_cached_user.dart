

import 'package:dartz/dartz.dart';
import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';

class SaveCachedUser implements UseCase<void, UserModel> {
  final AuthRepository repository;

  SaveCachedUser(this.repository);

  @override
  Future<Either<Failure, void>> call(UserModel user) async {
    return await repository.saveCachedUser(user);
  }
}
