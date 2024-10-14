import 'package:dartz/dartz.dart';
import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmail implements UseCase<UserModel, SignUpWithEmailParams> {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(SignUpWithEmailParams params) async {
    return await repository.signUpWithEmail(params.email, params.password, params.roles);
  }
}

class SignUpWithEmailParams {
  final String email;
  final String password;
  final String roles;

  SignUpWithEmailParams({required this.email, required this.password, required this.roles});
}
