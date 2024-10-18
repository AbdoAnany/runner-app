import 'package:dartz/dartz.dart';
import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<UserModel?, String> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserModel?>> call(String userId) async {
    return await repository.getUserData(userId);
  }
}