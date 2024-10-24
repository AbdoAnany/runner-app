import 'package:dartz/dartz.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../repositories/auth_repository.dart';


class SignInWithGoogle implements UseCase<UserDataDataModel, NoParams> {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserDataDataModel>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}