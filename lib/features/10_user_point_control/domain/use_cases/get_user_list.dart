import 'package:dartz/dartz.dart';
import 'package:runner_app/core/errors/failure.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../2_auth/data/models/UserDataDataModel.dart';
import '../repositories/user_control_repo.dart';

class GetUserListUseCase implements UseCase1<List<UserDataDataModel>, NoParams> {
  final UserControlRepository repository;

  GetUserListUseCase(this.repository);

  @override
  Future<Result<List<UserDataDataModel>>> call(NoParams params) async {
    return await repository.getUserList();
  }
}
