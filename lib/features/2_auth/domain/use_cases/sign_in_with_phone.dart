import 'package:dartz/dartz.dart';
import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';
class SignInWithPhone implements UseCase<UserModel, SignInWithPhoneParams> {
  final AuthRepository repository;

  SignInWithPhone(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(SignInWithPhoneParams params) async {
    return await repository.signInWithPhone(params.verificationId, params.smsCode);
  }
}

class SignInWithPhoneParams {
  final String verificationId;
  final String smsCode;

  SignInWithPhoneParams({required this.verificationId, required this.smsCode});
}
