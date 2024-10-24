import 'package:dartz/dartz.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';
class SignInWithPhone implements UseCase<UserDataDataModel, SignInWithPhoneParams> {
  final AuthRepository repository;

  SignInWithPhone(this.repository);

  @override
  Future<Either<Failure, UserDataDataModel>> call(SignInWithPhoneParams params) async {
    return await repository.signInWithPhone(params.verificationId, params.smsCode);
  }
}

class SignInWithPhoneParams {
  final String verificationId;
  final String smsCode;

  SignInWithPhoneParams({required this.verificationId, required this.smsCode});
}
