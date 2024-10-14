
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';


class CreateProfile implements UseCase<UserModel?, UserModel> {
  final AuthRepository repository;

  CreateProfile(this.repository);

  @override
  Future<Either<Failure, UserModel?>> call(UserModel params) async {
    return await repository.createUserData(params);
  }
}
// createUserData