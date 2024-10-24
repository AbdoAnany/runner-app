import 'package:dartz/dartz.dart';
import '../../../3_home/data/models/user_data_model.dart';
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
// class RolesLoad implements UseCase<UserDataDataModel, List<String>> {
//   final AuthRepository repository;
//
//   RolesLoad(this.repository);
//
//   @override
//   Future<Either<Failure, List<String>>> call() async {
//     return await repository.fetchRoleNames();
//   }
// }

