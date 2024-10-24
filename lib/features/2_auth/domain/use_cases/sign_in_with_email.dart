import 'package:dartz/dartz.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail implements UseCase<UserDataDataModel, SignInWithEmailParams> {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, UserDataDataModel>> call(SignInWithEmailParams params) async {
    return await repository.signInWithEmail(params.email, params.password);
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;

  SignInWithEmailParams({required this.email, required this.password});
}