import 'package:dartz/dartz.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<UserDataDataModel?, String> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserDataDataModel?>> call(String userId) async {
    return await repository.getUserData(userId);
  }
}