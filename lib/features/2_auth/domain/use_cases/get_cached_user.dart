
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class GetCachedUser implements UseCase<UserModel?, NoParams> {
  final AuthRepository repository;

  GetCachedUser(this.repository);

  @override
  Future<Either<Failure, UserModel?>> call(NoParams params) async {
    return await repository.getCachedUser();
  }
}

