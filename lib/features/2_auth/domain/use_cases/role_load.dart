import 'package:dartz/dartz.dart';
import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';
class RolesLoad implements UseCase<List<String>, NoParams> {
  final AuthRepository repository;

  RolesLoad(this.repository);

  @override
  Future<Either<Failure,List<String>>> call(NoParams params) async {
    return await repository.fetchRoleNames();
  }
}
// class RolesLoad implements UseCase<UserModel, List<String>> {
//   final AuthRepository repository;
//
//   RolesLoad(this.repository);
//
//   @override
//   Future<Either<Failure, List<String>>> call() async {
//     return await repository.fetchRoleNames();
//   }
// }

